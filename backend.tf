# comment to connect the backend to Terraform

# terraform {
#   backend "s3" {
#     bucket         = "clp-tfstate-938094936571-dev"               # Name of the S3 bucket
#     key            = "lesson-8-9/terraform.tfstate"               # Path to the state file
#     region         = "us-west-2"                                  # AWS region
#     dynamodb_table = "terraform-locks"                            # Name of the DynamoDB table
#     encrypt        = true                                         # Encryption of the state file
#   }
# }
