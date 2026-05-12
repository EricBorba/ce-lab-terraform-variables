variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "bucket_prefix" {
  description = "Prefix for S3 bucket name"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.bucket_prefix))
    error_message = "Bucket prefix must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "enable_versioning" {
  description = "Enable S3 bucket versioning"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

# ---------------------------------------------------------------
# Encryption Configuration
# ---------------------------------------------------------------

variable "enable_encryption" {
  description = "Enable server-side encryption for the S3 bucket"
  type        = bool
  default     = true
}

variable "encryption_algorithm" {
  description = "Server-side encryption algorithm (AES256 or aws:kms)"
  type        = string
  default     = "AES256"

  validation {
    condition     = contains(["AES256", "aws:kms"], var.encryption_algorithm)
    error_message = "Encryption algorithm must be AES256 or aws:kms."
  }
}

variable "kms_key_id" {
  description = "KMS key ID or ARN for aws:kms encryption. Leave null to use the default AWS-managed key."
  type        = string
  default     = null
}

# ---------------------------------------------------------------
# Lifecycle Rules
# ---------------------------------------------------------------

variable "enable_lifecycle_rules" {
  description = "Enable lifecycle rules on the S3 bucket"
  type        = bool
  default     = false
}

variable "lifecycle_rules" {
  description = "List of lifecycle rule configurations"
  type = list(object({
    id      = string
    enabled = bool

    # Transition current version to a cheaper storage class (days after creation)
    transition_days          = optional(number, null)
    transition_storage_class = optional(string, "STANDARD_IA")

    # Expire (delete) current versions after N days
    expiration_days = optional(number, null)

    # Clean up incomplete multipart uploads
    abort_incomplete_multipart_upload_days = optional(number, 7)
  }))
  default = []

  validation {
    condition = alltrue([
      for rule in var.lifecycle_rules :
      contains(["STANDARD_IA", "ONEZONE_IA", "INTELLIGENT_TIERING", "GLACIER", "DEEP_ARCHIVE"],
      coalesce(rule.transition_storage_class, "STANDARD_IA"))
    ])
    error_message = "transition_storage_class must be one of: STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, GLACIER, DEEP_ARCHIVE."
  }
}

# ---------------------------------------------------------------
# Logging Configuration
# ---------------------------------------------------------------

variable "enable_logging" {
  description = "Enable S3 access logging for the bucket"
  type        = bool
  default     = false
}

variable "logging_target_bucket" {
  description = "Name of the S3 bucket to deliver access logs to. Required when enable_logging is true."
  type        = string
  default     = null
}

variable "logging_target_prefix" {
  description = "Prefix for log object keys (e.g. 'logs/myapp-'). Helps separate logs per source bucket."
  type        = string
  default     = "logs/"
}
