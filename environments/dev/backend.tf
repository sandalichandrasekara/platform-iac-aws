terraform {
  backend "s3" {
    bucket       = "platform-iac-aws-tfstate" # created by /bootstrap
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true # S3 native state locking (no DynamoDB needed)
  }
}
