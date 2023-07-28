resource "aws_s3_bucket_policy" "cloudtrail" {
    bucket = aws_s3_bucket.cloudtrail.id
    policy = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck20150319",
            "Effect": "Allow",
            "Principal": {"Service": "cloudtrail.amazonaws.com"},
            "Action": "s3:GetBucketAcl",
            "Resource": "${aws_s3_bucket.cloudtrail.arn}",
            "Condition": {
                "ArnLike": {
                    "aws:SourceArn": [
                        "arn:aws:cloudtrail:${var.REGION}:${var.aws_account["prd"]}:trail/*", 
                        "arn:aws:cloudtrail:${var.REGION}:${var.aws_account["mgmt"]}:trail/*", 
                        "arn:aws:cloudtrail:${var.REGION}:${var.aws_account["logs"]}:trail/*", 
                        "arn:aws:cloudtrail:${var.REGION}:${var.aws_account["shared"]}:trail/*", 
                        "arn:aws:cloudtrail:${var.REGION}:${var.aws_account["sec"]}:trail/*", 
                        "arn:aws:cloudtrail:${var.REGION}:${var.aws_account["net"]}:trail/*", 
                        "arn:aws:cloudtrail:${var.REGION}:${var.aws_account["audit"]}:trail/*"
                    ]
                }
            }
        },
        {
            "Sid": "AWSCloudTrailWrite20150319",
            "Effect": "Allow",
            "Principal": {"Service": "cloudtrail.amazonaws.com"},
            "Action": "s3:PutObject",
            "Resource": "${aws_s3_bucket.cloudtrail.arn}/*",
            "Condition": {
                "StringLike": {
                    "s3:x-amz-acl": "bucket-owner-full-control",
                    "aws:SourceArn": [
                        "arn:aws:cloudtrail:${var.REGION}:${var.aws_account["prd"]}:trail/*", 
                        "arn:aws:cloudtrail:${var.REGION}:${var.aws_account["mgmt"]}:trail/*", 
                        "arn:aws:cloudtrail:${var.REGION}:${var.aws_account["logs"]}:trail/*", 
                        "arn:aws:cloudtrail:${var.REGION}:${var.aws_account["shared"]}:trail/*", 
                        "arn:aws:cloudtrail:${var.REGION}:${var.aws_account["sec"]}:trail/*", 
                        "arn:aws:cloudtrail:${var.REGION}:${var.aws_account["net"]}:trail/*", 
                        "arn:aws:cloudtrail:${var.REGION}:${var.aws_account["audit"]}:trail/*"
                    ]
                }
            }
        },
        {
            "Sid": "DenyUnencryptedTraffic",
            "Effect": "Deny",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:*",
            "Resource": "${aws_s3_bucket.cloudtrail.arn}/*",
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                }
            }
        }
    ]
}
EOT
}