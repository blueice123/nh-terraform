resource "aws_s3_bucket_policy" "vpc_flow" {
    bucket = aws_s3_bucket.vpc_flow.id
    policy = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSLogDeliveryWrite",
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": [
                    "${aws_s3_bucket.vpc_flow.arn}",
                    "${aws_s3_bucket.vpc_flow.arn}/*"
                ],
            "Condition": {
                "StringEquals": {
                    "aws:SourceAccount": [
                        "${var.aws_account["prd"]}", 
                        "${var.aws_account["mgmt"]}", 
                        "${var.aws_account["logs"]}", 
                        "${var.aws_account["shared"]}", 
                        "${var.aws_account["sec"]}", 
                        "${var.aws_account["net"]}", 
                        "${var.aws_account["audit"]}"
                    ],
                    "s3:x-amz-acl": "bucket-owner-full-control"
                },
                "ArnLike": {
                    "aws:SourceArn": [
                        "arn:aws:logs:${var.REGION}:${var.aws_account["prd"]}:*",
                        "arn:aws:logs:${var.REGION}:${var.aws_account["mgmt"]}:*",
                        "arn:aws:logs:${var.REGION}:${var.aws_account["logs"]}:*",
                        "arn:aws:logs:${var.REGION}:${var.aws_account["shared"]}:*",
                        "arn:aws:logs:${var.REGION}:${var.aws_account["sec"]}:*",
                        "arn:aws:logs:${var.REGION}:${var.aws_account["net"]}:*",
                        "arn:aws:logs:${var.REGION}:${var.aws_account["audit"]}:*"
                    ]
                }
            }
        },
        {
            "Sid": "AWSLogDeliveryAclCheck",
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": [
                "s3:GetBucketAcl",
                "s3:ListBucket"
            ],
            "Resource": "${aws_s3_bucket.vpc_flow.arn}",
            "Condition": {
                "StringEquals": {
                    "aws:SourceAccount": [
                        "${var.aws_account["prd"]}", 
                        "${var.aws_account["mgmt"]}", 
                        "${var.aws_account["logs"]}", 
                        "${var.aws_account["shared"]}", 
                        "${var.aws_account["sec"]}", 
                        "${var.aws_account["net"]}", 
                        "${var.aws_account["audit"]}"
                    ]
                },
                "ArnLike": {
                    "aws:SourceArn": [
                        "arn:aws:logs:${var.REGION}:${var.aws_account["prd"]}:*",
                        "arn:aws:logs:${var.REGION}:${var.aws_account["mgmt"]}:*",
                        "arn:aws:logs:${var.REGION}:${var.aws_account["logs"]}:*",
                        "arn:aws:logs:${var.REGION}:${var.aws_account["shared"]}:*",
                        "arn:aws:logs:${var.REGION}:${var.aws_account["sec"]}:*",
                        "arn:aws:logs:${var.REGION}:${var.aws_account["net"]}:*",
                        "arn:aws:logs:${var.REGION}:${var.aws_account["audit"]}:*"
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
            "Resource": "${aws_s3_bucket.vpc_flow.arn}/*",
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


