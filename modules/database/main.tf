resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$"
}

resource "aws_db_instance" "database" {
  allocated_storage      = 10
  db_name                = var.db_name
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_type
  username               = var.db_username
  password               = random_password.password.result
  skip_final_snapshot    = true
  db_subnet_group_name   = var.vpc.database_subnet_group_name
  vpc_security_group_ids = [var.sg.db_sg]
  multi_az               = false
}
