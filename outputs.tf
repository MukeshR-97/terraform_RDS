output "db_instance_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = module.rds.db_instance_endpoint
}

output "db_replica_endpoint" {
  description = "The endpoint of the RDS replica"
  value       = module.rds.db_replica_endpoint
}

output "restored_db_instance_endpoint" {
  description = "The endpoint of the restored RDS instance"
  value       = module.rds.restored_db_instance_endpoint
}
