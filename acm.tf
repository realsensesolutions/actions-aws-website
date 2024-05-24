resource "aws_acm_certificate" "website_cert" {
    domain_name = local.domain
    subject_alternative_names = ["www.${local.domain}"]
    validation_method = "DNS"

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_acm_certificate_validation" "website_cert" {
    certificate_arn = aws_acm_certificate.website_cert.arn
    validation_record_fqdns = [for record in aws_route53_record.cert_validation: record.fqdn]
}
