resource "aws_flow_log" "vpc_flow_logs" {
  log_destination      = var.flow_log_bucket_arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.main.id
}


resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = var.flow_log_bucket_name
  policy = data.aws_iam_policy_document.s3_flow_log_policy.json
}
