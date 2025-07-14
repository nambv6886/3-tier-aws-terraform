output "lb_dns" {
  value = module.alb.dns_name
}

output "ami_amzon_linux2_id" {
  description = "AMI ID used for the web servers"
  value       = data.aws_ami.amzlinux2.id
}
