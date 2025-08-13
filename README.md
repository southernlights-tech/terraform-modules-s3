# Generic S3 Terraform Module

This Terraform module provisions an AWS S3 bucket with several configurable features. It automatically enforces server-side encryption (AES256) and allows for versioning. The module supports custom lifecycle rules for object management and can enable Intelligent Tiering for cost optimization. Additionally, it can apply a default bucket policy to deny insecure (HTTP) transport, enhancing security.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_intelligent_tiering_configuration.intelligent_tiering_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_intelligent_tiering_configuration) | resource |
| [aws_s3_bucket_lifecycle_configuration.lifecycle_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_policy.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.encryption_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | S3 Bucket Name | `string` | n/a | yes |
| <a name="input_create_default_bucket_policy"></a> [create\_default\_bucket\_policy](#input\_create\_default\_bucket\_policy) | Let the module know if we need to create a policy | `bool` | `true` | no |
| <a name="input_custom_policy_statement"></a> [custom\_policy\_statement](#input\_custom\_policy\_statement) | Optional list of policy statements to merge with the default deny insecure transport statement. | `list(any)` | `[]` | no |
| <a name="input_enable_intelligent_tiering"></a> [enable\_intelligent\_tiering](#input\_enable\_intelligent\_tiering) | Enable Intelligent Tiering | `bool` | `true` | no |
| <a name="input_enable_intelligent_tiering_archive_access"></a> [enable\_intelligent\_tiering\_archive\_access](#input\_enable\_intelligent\_tiering\_archive\_access) | Intelligent Tiering Archive Access (in days) | `string` | `"90"` | no |
| <a name="input_enable_intelligent_tiering_deep_archive_access"></a> [enable\_intelligent\_tiering\_deep\_archive\_access](#input\_enable\_intelligent\_tiering\_deep\_archive\_access) | Intelligent Tiering Deep Archive Access (in days) | `string` | `"180"` | no |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | Short string for environment | `string` | n/a | yes |
| <a name="input_lifecycle_rules"></a> [lifecycle\_rules](#input\_lifecycle\_rules) | n/a | <pre>list(object({<br/>    id              = string<br/>    status          = string<br/>    expiration_days = optional(number)<br/>    noncurrent_version_transition = optional(object({<br/>      newer_noncurrent_versions = number<br/>      noncurrent_days           = number<br/>      storage_class             = string<br/>    }))<br/>    abort_incomplete_multipart_upload_days = optional(number)<br/>    expired_object_delete_marker           = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Enable Versioning | `string` | `"Enabled"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_outputs"></a> [outputs](#output\_outputs) | n/a |
<!-- END_TF_DOCS -->
