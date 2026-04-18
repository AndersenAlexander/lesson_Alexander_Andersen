# output "s3_bucket_name" {
#   description = "S3 bucket name for states"
#   value       = aws_s3_bucket.terraform_state.bucket
# }
#
# output "bucket_arn" {
#   description = "S3 bucket ARN"
#   value       = aws_s3_bucket.terraform_state.arn
# }
#
# output "dynamodb_table_name" {
#   description = "Name of the DynamoDB table for locking states"
#   value       = aws_dynamodb_table.terraform_locks.name
# }
#
# output "dynamodb_table_arn" {
#   description = "DynamoDB table ARN"
#   value       = aws_dynamodb_table.terraform_locks.arn
# }
