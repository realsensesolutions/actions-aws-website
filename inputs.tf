variable "hosted_zone_domain" {
  description = "Domain of the Hosted Zone"
  type        = string
}

variable "domain" {
  description = "Full domain to host the Website"
  type        = string
}

variable "alternate_domains" {
  description = "List of alternate domains (e.g., www.example.com) to be added as aliases"
  type        = list(string)
  default     = []
}

variable "spa" {
  description = "Enable SPA (Single Page Application) routing support"
  type        = bool
  default     = false
}