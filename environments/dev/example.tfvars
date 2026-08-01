# Copy to terraform.tfvars and adjust. All values are optional (have defaults).
project     = "platform"
environment = "dev"
region      = "us-east-1"

# Set an email to receive CloudWatch alarm notifications (confirm the SNS
# subscription email AWS sends after apply).
alarm_email = ""
