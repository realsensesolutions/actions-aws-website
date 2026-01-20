resource "aws_cloudfront_origin_access_identity" "oai" {}

resource "aws_cloudfront_distribution" "cloudfront" {
  default_root_object = "index.html"
  enabled             = true
  is_ipv6_enabled     = true
  aliases             = var.domain != "" ? concat([var.domain], var.alternate_domains) : []
  # Distributes content to US and Europe
  price_class = "PriceClass_100"

  origin {
    domain_name = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id   = "S3-${aws_s3_bucket.website.bucket}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods        = ["HEAD", "GET", "OPTIONS"]
    cached_methods         = ["HEAD", "GET"]
    target_origin_id       = "S3-${aws_s3_bucket.website.bucket}"
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }
  }

  # Custom error response for SPA routing (404 errors)
  dynamic "custom_error_response" {
    for_each = var.spa ? [1] : []
    content {
      error_code         = 404
      response_code      = 200
      response_page_path = "/index.html"
      error_caching_min_ttl = 0
    }
  }

  # Custom error response for SPA routing (403 errors)
  dynamic "custom_error_response" {
    for_each = var.spa ? [1] : []
    content {
      error_code         = 403
      response_code      = 200
      response_page_path = "/index.html"
      error_caching_min_ttl = 0
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  dynamic "viewer_certificate" {
    for_each = var.domain != "" ? toset([1]) : toset([])

    content {
      acm_certificate_arn = aws_acm_certificate.website_cert[0].arn
      ssl_support_method  = "sni-only"
    }
  }

  dynamic "viewer_certificate" {
    for_each = var.domain != "" ? toset([]) : toset([1])

    content {
      cloudfront_default_certificate = true
    }
  } 

}
