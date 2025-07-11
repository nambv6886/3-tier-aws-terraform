resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!%@"
}

resource "aws_db_instance" "database" {
  allocated_storage      = 10
  db_name                = "mydb"
  engine                 = "postgresql"
  engine_version         = "12.7"
  instance_class         = "db.t2.micro"
  username               = "admin"
  password               = random_password.password.result
  skip_final_snapshot    = true
  db_subnet_group_name   = var.vpc.database_subnet_group_name
  vpc_security_group_ids = [var.sg.db_sg]
  multi_az               = false
}
