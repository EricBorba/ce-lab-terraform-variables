environment       = "staging"
bucket_prefix     = "myapp-ericborba"
enable_versioning = true # or true if testing versioning workflows
aws_region        = "us-east-1"

tags = {
  Owner   = "PlatformTeam"
  Project = "CloudBootcamp"
  Cost    = "Staging" # was "Production" — fix for cost allocation
  Backup  = "None"    # was "Daily" — not needed for staging
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
