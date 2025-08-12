# Generic S3 Terraform Module

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_intelligent_tiering_configuration.intelligent_tiering_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_intelligent_tiering_configuration) | resource |
| [aws_s3_bucket_lifecycle_configuration.lifecycle_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.encryption_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket_name](#input_bucket_name) | S3 Bucket Name | `string` | n/a | yes |
| <a name="input_create_default_bucket_policy"></a> [create_default_bucket_policy](#input_create_default_bucket_policy) | Let the module know if we need to create a policy to deny insecure transport | `bool` | `true` | no |
| <a name="input_enable_intelligent_tiering"></a> [enable_intelligent_tiering](#input_enable_intelligent_tiering) | Enable Intelligent Tiering | `bool` | `true` | no |
| <a name="input_enable_intelligent_tiering_archive_access"></a> [enable_intelligent_tiering_archive_access](#input_enable_intelligent_tiering_archive_access) | Intelligent Tiering Archive Access (in days) | `string` | `"90"` | no |
| <a name="input_enable_intelligent_tiering_deep_archive_access"></a> [enable_intelligent_tiering_deep_archive_access](#input_enable_intelligent_tiering_deep_archive_access) | Intelligent Tiering Deep Archive Access (in days) | `string` | `"180"` | no |
| <a name="input_env_short"></a> [env_short](#input_env_short) | Short string for environment | `string` | n/a | yes |
| <a name="input_lifecycle_rules"></a> [lifecycle_rules](#input_lifecycle_rules) | n/a | <pre>list(object({<br>    id        = string<br>    status    = string<br>    expiration_days = optional(number)<br>    noncurrent_version_transition = optional(object({<br>      newer_noncurrent_versions = number<br>      noncurrent_days           = number<br>      storage_class             = string<br>    }))<br>    abort_incomplete_multipart_upload_days = optional(number)<br>    expired_object_delete_marker = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_versioning"></a> [versioning](#input_versioning) | Enable Versioning | `string` | `"Enabled"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output_arn) | The ARN of the S3 bucket. |
| <a name="output_bucket"></a> [bucket](#output_bucket) | The name of the S3 bucket. |
| <a name="output_bucket_domain_name"></a> [bucket_domain_name](#output_bucket_domain_name) | The domain name of the S3 bucket. |
| <a name="output_deny_http_statement"></a> [deny_http_statement](#output_deny_http_statement) | A JSON policy statement to deny insecure transport (HTTP) to the bucket. |
<!-- END_TF_DOCS -->

