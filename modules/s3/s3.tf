resource "aws_s3_bucket" "main" {
  bucket        = "${local.tag_environment}-${var.bucket_name}"
  force_destroy = false
}

resource "aws_s3_bucket_public_access_block" "main" {
  count  = var.s3_block_public_access == true ? 1 : 0
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption" {
  count  = var.s3_encryption == "AES256" ? 1 : 0
  bucket = aws_s3_bucket.main.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "main" {
  count  = var.s3_versioning == "Enabled" ? 1 : 0
  bucket = aws_s3_bucket.main.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  count  = var.s3_default_bucket_policy == true ? 1 : 0
  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.s3_bucket_policy.json
}