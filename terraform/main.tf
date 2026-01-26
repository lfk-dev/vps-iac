# instance naming: https://docs.aws.amazon.com/ec2/latest/instancetypes/instance-type-names.html
# instance t3a.small has 2 vCPU and 2 GB of RAM which is plenty based on prometheus queries 
# that show  less than 800mb of ram used, and 5% cpu util (6 vcores)
# t - burstable, 3 - generation, a - AMD, small - size (arbitrary per instance type)
resource "aws_instance" "VPS" {
  ami           = "ami-01f79b1e4a5c64257"
  instance_type = "t2.micro"
  tags = {
    Name = "VPS"
  }
  # The "glue" that connects the instance to be launched in the public subnet
  # with SG rules attached to it.
  subnet_id       = aws_subnet.public.id
  security_groups = [aws_security_group.main.id]

  # ssh key to use for access
  key_name = "aws_dev"
}

# specify an EIP in to be used inisde a VPC
resource "aws_eip" "vps" {
  domain = "vpc"
}

# Associate the EIP with the instace (more modular, but could be defined in aws_eip resource block)
resource "aws_eip_association" "vps" {
  instance_id   = aws_instance.VPS.id
  allocation_id = aws_eip.vps.id
}
