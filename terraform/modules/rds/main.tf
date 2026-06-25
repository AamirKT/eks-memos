resource "aws_db_instance" "main" {
  identifier             = var.db_instance_identifier
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  allocated_storage      = var.db_allocated_storage
  db_name                = var.db_name
  username               = var.db_username
  password               = random_password.db_password.result
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = var.rds_sg_id
  multi_az               = var.db_multi_az
  skip_final_snapshot    = var.skip_final_snapshot

  tags = {
    Name = var.db_instance_identifier
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "${var.db_instance_identifier}-subnet-group"
  subnet_ids = var.vpc_private_subnet_ids

  tags = {
    Name = "${var.db_instance_identifier}-subnet-group"
  }
}

resource "random_password" "db_password" {
  length           = 24
  special          = true
  override_special = "!$%&*-_=+"
}

locals {
  memos_dsn = "postgres://${var.db_username}:${urlencode(random_password.db_password.result)}@${aws_db_instance.main.address}:5432/${var.db_name}"
}

resource "aws_secretsmanager_secret" "db_password" {
  name                    = "${var.db_instance_identifier}-db-password"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "db_password_version" {
  secret_id = aws_secretsmanager_secret.db_password.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db_password.result
    hostname = aws_db_instance.main.address
    port     = "5432"
    dbname   = var.db_name
    dsn      = "postgres://${var.db_username}:${urlencode(random_password.db_password.result)}@${aws_db_instance.main.address}:5432/${var.db_name}"
  })
}
