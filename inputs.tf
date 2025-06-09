variable "hosted_zone_domain" {
  description = "Domain of the Hosted Zone"
  type        = string
}

variable "domain" {
  description = "Full domain to host the Website"
  type        = string
}

variable "spa" {
  description = "Enable SPA (Single Page Application) routing support"
  type        = bool
  default     = false
}