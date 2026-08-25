output "endpoint" {
  description = "Cluster (writer) endpoint for the application to connect to."
  value       = aws_docdb_cluster.this.endpoint
}

output "reader_endpoint" {
  description = "Read-only endpoint."
  value       = aws_docdb_cluster.this.reader_endpoint
}

output "port" {
  description = "DocumentDB port."
  value       = var.port
}

output "secret_arn" {
  description = "ARN of the Secrets Manager secret holding DB credentials."
  value       = aws_secretsmanager_secret.db.arn
}
