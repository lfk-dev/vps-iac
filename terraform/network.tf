# Outbound:
# Instance (in public subnet) -> Route table -> Internet gatway -> Internet
# Inbound:
# Internet gateway -> Security groups(firewall) -> Instance 




# VPC resources defines the VPC as a whole, but the elements of it are seperate resources that point to it
resource "aws_vpc" "main" {
  enable_dns_support   = true          # DNS for the resources in VPC (both internally and externally)
  enable_dns_hostnames = true          # Hostnames for resources in VPC (interna resolution)
  cidr_block           = "10.0.0.0/16" # the block for whole VPS that we can carve into subnets
  tags = {
    Name = "${local.aws_tag}-vpc"
  }
}

# Subnets have default gateway configured automatically as well as DNS server (internal)
# AWS reserves 5 IPs in each subnet: network address (.0), VPC router (.1), DNS (.2), future use (.3), broadcast (.255).
# That is also why there is no "router" resource, only routing table that is associated with subnet and internet gateway
# subnet for VPC, that is public (allows for traffic outside VPC)
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  # map_public_ip_on_launch = true # Assign public IP to instances launched in this subnet
  # Not needed, since we are using EIP
  tags = {
    Name = "${local.aws_tag}-public_subnet"
  }
}

# Internet gatway does not have it's own IP!
# The exposed(reachable) IPs are the IPs of the instances.
# The gateway does mapping between Instance public IP and VPC(subnet) private IP (1 to 1)
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.aws_tag}-igw"
  }
}

# === FIREWALL ===
# Firewall can controll both in/outbound traffic
# Firewalls attach to the instances inside the VPC. That is why security groups are VPC level concept (not per subnets or per router)
# Security groups must be explicitly attached to the provisioned instances to work
resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id

  # "dynamic" means the values are generated into the sytnax
  dynamic "ingress" {
    for_each = [22, 80, 443]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # egress generally does not need to be restricted
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.aws_tag}-sg"
  }
}
# === ROUTING ===
# Define a route table for the VPC
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id # which VPC this route table exists in
  tags = {
    Name = "${local.aws_tag}-rt"
  }
}

# Create the route in the route table
# Specify the outbound traffic routing to the internet gateway
resource "aws_route" "main" {
  route_table_id         = aws_route_table.main.id # which route table this rule belongs to
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id

}

# Specify what route table should be used for the subnet
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.public.id    # which subnet
  route_table_id = aws_route_table.main.id # uses which route table
}

# NOTE: The domain is managed externally to terraform, but on AWS
# It should be provided as a secret. TF will adjust the DNS records for the 
# elastic IP and the subdomains.

# get the zone ID from AWS based on provided domain name
data "aws_route53_zone" "domain" {
  name         = var.vps_domain
  private_zone = false
}

# Create new records in that domain
resource "aws_route53_record" "subdomains" {
  for_each = var.services

  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "${each.key}.${var.vps_domain}"
  type    = "A"
  ttl     = 60

  records = [aws_eip.vps.public_ip]
}
