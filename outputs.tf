output "db_password" {
  value     = module.database.config.password
  sensitive = true
}

output "lb_dns" {
  value = module.autoscaling.lb_dns
}

output "bastion_host_public_eip" {
  value = module.bastion.bastion_host_public_eip
}
