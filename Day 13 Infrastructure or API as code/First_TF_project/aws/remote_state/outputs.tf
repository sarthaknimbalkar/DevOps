# ----------------------------------------------------------------------------------------------------------------------
# OUTPUT THE S3 BUCKET AND DYNAMODB TABLE DETAILS
# ----------------------------------------------------------------------------------------------------------------------

output "s3_bucket_name" {
  value       = aws_s3_bucket.terraform_state.id
  description = "The name of the S3 bucket used for Terraform state storage."
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket used for Terraform state storage."
}

output "s3_bucket_region" {
  value       = aws_s3_bucket.terraform_state.region
  description = "The region of the S3 bucket used for Terraform state storage."
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_lock.name
  description = "The name of the DynamoDB table used for Terraform state locking."
}

output "dynamodb_table_arn" {
  value       = aws_dynamodb_table.terraform_lock.arn
  description = "The ARN of the DynamoDB table used for Terraform state locking."
}
