resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}-${var.env_short}"

  # todo: add mechanism to add this lifecycle rule only if env is prod or it is
  # explicitly defined
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption_configuration" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    bucket_key_enabled = true

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = var.versioning
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_configuration" {
  bucket = aws_s3_bucket.bucket.id

  dynamic "rule" {
    for_each = var.lifecycle_rules
    content {
      id     = rule.value.id
      status = rule.value.status

      # Set expiration if defined
      expiration {
        days = rule.value.expiration_days
      }

      filter {
        prefix = ""
      }

      # Set noncurrent version transition if defined
      dynamic "noncurrent_version_transition" {
        for_each = rule.value.noncurrent_version_transition != null ? [rule.value.noncurrent_version_transition] : []
        content {
          newer_noncurrent_versions = noncurrent_version_transition.value.newer_noncurrent_versions
          noncurrent_days           = noncurrent_version_transition.value.noncurrent_days
          storage_class             = noncurrent_version_transition.value.storage_class
        }
      }
    }
  }

  rule {
    id     = "delete-expired-objects"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 3
    }

    expiration {
      expired_object_delete_marker = true
    }

    filter {
      prefix = ""
    }
  }
}

resource "aws_s3_bucket_intelligent_tiering_configuration" "intelligent_tiering_configuration" {
  count = var.enable_intelligent_tiering == true ? 1 : 0

  bucket = aws_s3_bucket.bucket.id

  name = "intelligent-tiering-config" # Add a unique name for your configuration

  tiering {
    days        = var.enable_intelligent_tiering_archive_access
    access_tier = "ARCHIVE_ACCESS"
  }

  tiering {
    days        = var.enable_intelligent_tiering_deep_archive_access
    access_tier = "DEEP_ARCHIVE_ACCESS"
  }
}

locals {
  create_default_bucket_policy = var.create_default_bucket_policy || length(var.custom_policy_statement) > 0

  deny_insecure_transport_statement = var.create_default_bucket_policy ? [{
    Sid       = "DenyInsecureTransport"
    Effect    = "Deny"
    Principal = "*"
    Action    = "s3:*"
    Resource = [
      "${aws_s3_bucket.bucket.arn}/*",
      "${aws_s3_bucket.bucket.arn}",
    ]
    Condition = {
      Bool = {
        "aws:SecureTransport" = "false"
      }
    }
  }] : []

  merged_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = concat(var.custom_policy_statement, local.deny_insecure_transport_statement)
  })
}

# If the flag is not changed, we create a deny http policy by default for the bucket
resource "aws_s3_bucket_policy" "bucket_policy" {
  count  = local.create_default_bucket_policy ? 1 : 0
  bucket = aws_s3_bucket.bucket.id
  policy = local.merged_policy
}
