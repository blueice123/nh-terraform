## 참고 내용
## ALB의 경우 AWS공식 계정에서 로그를 쌓아주기 때문에 다른 서비스와 Policy 설정이 좀 다름
## https://docs.aws.amazon.com/elasticloadbalancing/latest/application/enable-access-logging.html#access-log-create-bucket
resource "aws_s3_bucket_policy" "alb" {
    bucket = aws_s3_bucket.alb.id
    policy = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "logdelivery.elasticloadbalancing.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": [
                "${aws_s3_bucket.alb.arn}/*",
                "${aws_s3_bucket.alb.arn}"
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
                    ]
                }
            }
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::600734575887:root"
            },
            "Action": "s3:PutObject",
            "Resource": [
                "${aws_s3_bucket.alb.arn}/*",
                "${aws_s3_bucket.alb.arn}"
            ]
        },
        {
            "Sid": "DenyUnencryptedTraffic",
            "Effect": "Deny",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:*",
            "Resource": "${aws_s3_bucket.alb.arn}/*",
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