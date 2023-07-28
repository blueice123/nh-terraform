resource "aws_s3_bucket" "vpc_flow" {
  bucket = var.s3_vpc_flow_logs["name"] 

  tags = {
    Environment = "logs"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "vpc_flow" {
  bucket = aws_s3_bucket.vpc_flow.id

  rule {
    id = "expire-5years"
    filter {
      prefix = "*"
    }
    expiration {
      days = var.s3_vpc_flow_logs["expire_days"] 
    }
    status = "Enabled"
  }
  rule {
    id = "transition-class" 
    filter {
      prefix = "*"
    }
    transition {
      days          = var.s3_vpc_flow_logs["transition_to_INTELLIGENT_TIERING"]
      storage_class = "INTELLIGENT_TIERING"
    }
    status = "Enabled"
  }
}