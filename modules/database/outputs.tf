output "config" {
  value = {
    username = aws_db_instance.database.username
    password = aws_db_instance.database.password
    port     = aws_db_instance.database.port
    hostname = aws_db_instance.database.address
    db_name  = aws_db_instance.database.db_name
  }
}
