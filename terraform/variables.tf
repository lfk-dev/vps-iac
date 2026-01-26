# List of all subdomains to create DNS records for
variable "services" {
  type = set(string)
  default = [
    "traefik"
  ]
}

variable "vps_domain" {
  type = string
}

