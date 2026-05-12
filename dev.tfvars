environment       = "dev"
bucket_prefix     = "myapp-ericborba"
enable_versioning = false
aws_region        = "us-east-1"

tags = {
  Owner   = "DevTeam"
  Project = "CloudBootcamp"
  Cost    = "Development"
}

enable_encryption    = true
encryption_algorithm = "AES256"

enable_lifecycle_rules = true
lifecycle_rules = [
  {
    id              = "expire-old-objects"
    enabled         = true
    expiration_days = 30
  }
]

enable_logging        = true
logging_target_bucket = "myapp-ericborba-logs-dev" # must already exist
logging_target_prefix = "logs/myapp-dev-"
