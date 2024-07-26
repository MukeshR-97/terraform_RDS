provider "aws" {
  region = var.region
}

module "rds" {
  source            = "./modules/rds"
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  vpc_id            = var.vpc_id
  subnet_ids        = var.subnet_ids
  region            = var.region
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  snapshot_identifier     = var.snapshot_identifier
}

output "db_instance_endpoint" {
  value = module.rds.db_instance_endpoint
}

output "db_replica_endpoint" {
  value = module.rds.db_replica_endpoint
}

output "restored_db_instance_endpoint" {
  value = module.rds.restored_db_instance_endpoint
}