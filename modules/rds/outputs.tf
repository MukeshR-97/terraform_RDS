output "db_instance_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.main.endpoint
}

output "db_replica_endpoint" {
  description = "The endpoint of the RDS replica"
  value       = aws_db_instance.replica.endpoint
}

output "restored_db_instance_endpoint" {
  description = "The endpoint of the restored RDS instance"
  value       = module.rds.restored_db_instance_endpoint
}