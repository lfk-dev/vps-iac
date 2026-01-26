# Outputs are predefined variables that TF will automatically parse 
# and fill, based on the state file.

# We need that ip for for route53 later
output "instance_public_ip" {
  value = aws_instance.VPS.public_ip
}
