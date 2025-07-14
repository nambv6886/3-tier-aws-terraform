output "bastion_host_public_eip" {
  description = "value of the EC2 public instance EIP"
  value       = aws_eip.bastion_host_eip.public_ip
}
