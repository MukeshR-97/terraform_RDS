resource "aws_db_parameter_group" "default" {
  name        = "custom-mysql-parameter-group"
  family      = "mysql8.0"
  description = "Custom MySQL parameter group"

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "max_connections"
    value = "200"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "rds-subnet-group"
  }
}

resource "aws_security_group" "rds" {
  name        = "rds-security-group"
  description = "RDS security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-security-group"
  }
}

resource "aws_db_instance" "main" {
  identifier              = "mydb-instance"
  allocated_storage       = var.allocated_storage
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = var.instance_class
  name                    = var.db_name
  username                = var.db_username
  password                = var.db_password
  publicly_accessible     = false
  multi_az                = false
  parameter_group_name    = aws_db_parameter_group.default.name
  db_subnet_group_name    = aws_db_subnet_group.default.name
  vpc_security_group_ids  = [aws_security_group.rds.id]
  skip_final_snapshot     = true
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window

  tags = {
    Name = "MainDB"
  }

  depends_on = [aws_db_subnet_group.default, aws_security_group.rds]

}


resource "aws_db_instance" "replica" {
  identifier              = "mydb-replica"
  replicate_source_db     = aws_db_instance.main.id
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  engine                  = "mysql"
  engine_version          = "8.0"
  multi_az                = false
  parameter_group_name    = aws_db_parameter_group.default.name
  db_subnet_group_name    = aws_db_subnet_group.default.name
  vpc_security_group_ids  = [aws_security_group.rds.id]
  skip_final_snapshot     = true
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window

  tags = {
    Name = "ReadReplica"
  }

  depends_on = [aws_db_subnet_group.default, aws_security_group.rds]

}


resource "aws_db_snapshot" "snapshot" {
  db_instance_identifier = aws_db_instance.main.id
  db_snapshot_identifier = "mydb-snapshot"

  tags = {
    Name = "MyDBSnapshot"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_instance" "restored" {
  count                   = var.restore_snapshot ? 1 : 0
  identifier              = "restored-db-instance"
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  engine                  = "mysql"
  engine_version          = "8.0"
  multi_az                = false
  snapshot_identifier     = var.snapshot_identifier
  parameter_group_name    = aws_db_parameter_group.default.name
  db_subnet_group_name    = aws_db_subnet_group.default.name
  vpc_security_group_ids  = [aws_security_group.rds.id]
  skip_final_snapshot     = true
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window

  tags = {
    Name = "RestoredDB"
  }

  depends_on = [aws_db_subnet_group.default, aws_security_group.rds]
}