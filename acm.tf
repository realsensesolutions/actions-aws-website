resource "aws_acm_certificate" "website_cert" {
  count                     = var.domain != "" ? 1 : 0 
  domain_name               = var.domain
  subject_alternative_names = length(var.alternate_domains) > 0 ? var.alternate_domains : null
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "website_cert" {
  count                   = var.domain != "" ? 1 : 0
  certificate_arn         = aws_acm_certificate.website_cert[0].arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
