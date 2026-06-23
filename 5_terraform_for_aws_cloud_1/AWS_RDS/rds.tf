# RDS Subnet Group
resource "aws_db_subnet_group" "mariadb_subnets" {
  name        = "mariadb-subnets"
  description = "Amazon RDS subnet group"

  subnet_ids = [
    aws_subnet.levelupvpc_private_1.id,
    aws_subnet.levelupvpc_private_2.id
  ]

  tags = {
    Name = "MariaDB subnet group"
  }
}

# RDS Parameter Group
resource "aws_db_parameter_group" "levelup_mariadb_parameters" {
  name        = "levelup-mariadb-parameters"
  family      = "mariadb10.11"
  description = "MariaDB parameter group"

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}

# MariaDB Instance
resource "aws_db_instance" "levelup_mariadb" {
  allocated_storage      = 20
  storage_type           = "gp2"

  engine                 = "mariadb"
  engine_version         = "10.11"

  instance_class         = "db.t3.micro"

  identifier             = "mariadb"

  db_name                = "mariadb"
  username               = "root"
  password               = "mariadb141"

  db_subnet_group_name   = aws_db_subnet_group.mariadb_subnets.name
  parameter_group_name   = aws_db_parameter_group.levelup_mariadb_parameters.name

  vpc_security_group_ids = [
    aws_security_group.allow_mariadb.id
  ]

  availability_zone      = aws_subnet.levelupvpc_private_1.availability_zone

  multi_az               = false
  backup_retention_period = 30

  skip_final_snapshot    = true

  tags = {
    Name = "levelup-mariadb"
  }
}

output "rds" {
  value = aws_db_instance.levelup_mariadb.endpoint
}