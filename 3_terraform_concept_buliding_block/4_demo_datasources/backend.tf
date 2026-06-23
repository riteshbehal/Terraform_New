terraform {
    backend "s3" {
        bucket = "tf-bucket01-001"
        key    = "development/terraform_state"
        region = "us-east-1"
    }
}
