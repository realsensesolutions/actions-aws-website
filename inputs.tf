variable "hosted_zone_domain" {
    description = "Domain of the Hosted Zone"
    type = string
}

variable "subdomain" { 
    description = "Optional Subdomain to host the Website"
    type = string
    default = ""
}

locals {
  domain = subdomain ? "${var.subdomain}.${var.hosted_zone_domain}" : "${var.hosted_zone_domain}"
}