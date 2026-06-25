output "db_instance_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.main.endpoint
}

output "rds_secret_arn" {
  description = "The ARN of the secret containing the RDS credentials"
  value       = aws_secretsmanager_secret.db_password.arn
}

