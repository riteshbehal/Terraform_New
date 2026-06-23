resource "aws_key_pair" "levelup_key" {
  key_name   = "levelup_key"
  public_key = file("${path.module}/levelup_key.pub")
}

resource "aws_launch_template" "levelup_launchtemplate" {
  depends_on = [
    aws_key_pair.levelup_key
  ]

  name_prefix   = "levelup-launchtemplate"
  image_id      = "ami-0b6d9d3d33ba97d99"
  instance_type = "t2.micro"

  key_name = aws_key_pair.levelup_key.key_name

  vpc_security_group_ids = [
    aws_security_group.levelup-instance.id
  ]

  user_data = base64encode(<<-EOF
#!/bin/bash

apt-get update -y
apt-get install -y apache2

mkdir -p /var/www/html

IP=$(hostname -I | awk '{print $1}')

cat > /var/www/html/index.html <<HTML
Hello Team
This is my IP: $IP
HTML

systemctl enable apache2
systemctl restart apache2
EOF
)

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "LevelUp Custom EC2 instance via LB"
    }
  }
}

resource "aws_autoscaling_group" "levelup-autoscaling" {
  name                      = "levelup-autoscaling"
  max_size                  = 2
  min_size                  = 2
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true

  launch_template {
    id      = aws_launch_template.levelup_launchtemplate.id
    version = "$Latest"
  }

  vpc_zone_identifier = [
    aws_subnet.levelupvpc-public-1.id,
    aws_subnet.levelupvpc-public-2.id,
    aws_subnet.levelupvpc-public-3.id
  ]

  load_balancers = [
    aws_elb.levelup-elb.name
  ]

  tag {
    key                 = "Name"
    value               = "LevelUp Custom EC2 instance via LB"
    propagate_at_launch = true
  }
}