region            = "us-east-1"
db_name           = "mydatabase"
db_username       = "admin"
db_password       = "password1234"
instance_class    = "db.t3.micro"
allocated_storage = 20
vpc_id            = "vpc-xxxxxxxx"
subnet_ids        = ["subnet-xxxxxxxx", "subnet-yyyyyyyy"]
backup_retention_period = 7
backup_window          = "03:00-04:00"
snapshot_identifier    = "mydb-snapshot-identifier"
restore_snapshot       = true