resource "aws_route53_zone" "zone" {
  name = var.domain_name

  force_destroy = var.force_destroy
  dynamic vpc {
    for_each = var.is_internal == true ? [true] : []
    content {
      vpc_id =  var.vpc_id
    }
  }
  
  tags = var.common_tags
}
