variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_username" {
  description = "The username for the database"
  type        = string
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage size for the RDS instance"
  type        = number
}

variable "vpc_id" {
  description = "The VPC ID where RDS will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs for the RDS subnet group"
  type        = list(string)
}

variable "backup_retention_period" {
  description = "The number of days to retain backups"
  type        = number
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created"
  type        = string
}

variable "snapshot_identifier" {
  description = "The identifier for the DB snapshot to restore from"
  type        = string
  default     = ""
}

variable "restore_snapshot" {
  description = "Whether to restore the DB instance from a snapshot"
  type        = bool
  default     = false
}