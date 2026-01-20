data "aws_route53_zone" "primary" {
  count = var.hosted_zone_domain != "" ? 1 : 0
  name  = var.hosted_zone_domain
}

resource "aws_route53_record" "domain" {
  count   = var.domain != "" ? 1 : 0
  zone_id = data.aws_route53_zone.primary[0].zone_id
  name    = var.domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cloudfront.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "alternate_domains" {
  for_each = toset(var.alternate_domains)
  zone_id  = data.aws_route53_zone.primary[0].zone_id
  name     = each.value
  type     = "A"

  alias {
    name                   = aws_cloudfront_distribution.cloudfront.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in var.domain != "" ? aws_acm_certificate.website_cert[0].domain_validation_options : [] : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.primary[0].zone_id
}