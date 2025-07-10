output "vpc" {
  value = module.vpc
}

output "sg" {
  value = {
    alb_sg = module.alb_sg.security_group_id
    db_sg  = module.db_sg.security_group_id
    web_sg = module.web_sg.security_group_id
  }
}
