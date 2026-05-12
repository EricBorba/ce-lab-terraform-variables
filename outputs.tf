output "bucket_id" {
  description = "ID (name) of the S3 bucket"
  value       = aws_s3_bucket.main.id
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.main.arn
}

output "bucket_region" {
  description = "Region where bucket is deployed"
  value       = aws_s3_bucket.main.region
}

output "versioning_enabled" {
  description = "Whether versioning is enabled"
  value       = var.enable_versioning
}
