variable "bucket_name" {
  type    = string
  description = "S3 Bucket Name"
}

variable "env_short" {
  description = "Short string for environment"
  type        = string
}

variable "enable_intelligent_tiering" {
  description = "Enable Intelligent Tiering"
  type        = bool
  default     = true
}

variable "enable_intelligent_tiering_archive_access" {
  description = "Intelligent Tiering Archive Access (in days)"
  type        = string
  default     = "90"
}

variable "enable_intelligent_tiering_deep_archive_access" {
  description = "Intelligent Tiering Deep Archive Access (in days)"
  type        = string
  default     = "180"
}

variable "create_default_bucket_policy" {
  description = "Let the module know if we need to create a policy"
  type = bool
  default = true
}

variable "versioning" {
  description = "Enable Versioning"
  type        = string
  default     = "Enabled"
}

variable "lifecycle_rules" {
  type = list(object({
    id        = string
    status    = string
    expiration_days = optional(number)
    noncurrent_version_transition = optional(object({
      newer_noncurrent_versions = number
      noncurrent_days           = number
      storage_class             = string
    }))
    abort_incomplete_multipart_upload_days = optional(number)
    expired_object_delete_marker = optional(bool)
  }))

  default = []
}
