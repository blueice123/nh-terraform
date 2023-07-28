output "aws_account_id" {
  value = data.aws_caller_identity.current.id
}
# output "aws_account_prd" {
#   value = var.aws_account["prd"]
# }
output "s3_vpc_flow" {
  value       = aws_s3_bucket.vpc_flow.id
}
output "s3_vpc_flow_arn" {
  value       = aws_s3_bucket.vpc_flow.arn
}

output "s3_cloudtrail" {
  value       = aws_s3_bucket.cloudtrail.id
}
output "s3_cloudtrail_arn" {
  value       = aws_s3_bucket.cloudtrail.arn
}

