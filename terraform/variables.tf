# List of all subdomains to create DNS records for
variable "services" {
  type = set(string)
  default = [
    "traefik",
    "whoami",
    "kanboard"
  ]
}

variable "vps_domain" {
  type = string
}

