resource "aws_s3_bucket" "alb" {
  bucket = var.s3_alb_access_logs["name"]

  tags = {
    Environment = "logs"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "alb" {
  bucket = aws_s3_bucket.alb.id

  rule {
    id = "expire-5years"
    filter {
      prefix = "*"
    }
    expiration {
      days = var.s3_alb_access_logs["expire_days"] #1825 #5년 
    }
    status = "Enabled"
  }
  rule {
    id = "transition-class" 
    filter {
      prefix = "*"
    }
    transition {
      days          = var.s3_alb_access_logs["transition_to_INTELLIGENT_TIERING"]
      storage_class = "INTELLIGENT_TIERING"
    }
    status = "Enabled"
  }
}