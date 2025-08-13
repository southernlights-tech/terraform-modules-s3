output "outputs" {
  value = {
    arn                 = resource.aws_s3_bucket.bucket.arn
    bucket              = resource.aws_s3_bucket.bucket.bucket
    bucket_domain_name  = resource.aws_s3_bucket.bucket.bucket_domain_name
    deny_http_statement = local.merged_policy
  }
}
