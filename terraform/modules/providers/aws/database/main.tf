resource "aws_db_subnet_group" "db_subnet" {
  name       = "${var.namespace}-group"
  subnet_ids = var.vpc.private_subnets
}

resource "aws_db_instance" "database" {
  instance_class          = var.database_config.instance_class
  engine                  = var.database_config.engine
  engine_version          = var.database_config.engine_version
  username                = var.database_config.username
  password                = var.database_config.password
  allocated_storage       = var.database_config.allocated_storage
  db_name                 = var.database_config.name
  backup_retention_period = var.database_config.backup_retention
  identifier              = var.database_config.instance_identifier
  storage_type            = var.database_config.storage_type
  port                    = var.database_config.port

  db_subnet_group_name       = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids     = var.database_config.security_group_ids
  auto_minor_version_upgrade = var.database_config.auto_minor_version_upgrade
  skip_final_snapshot        = var.database_config.skip_final_snapshot
  multi_az                   = var.database_config.multi_az
  storage_encrypted          = var.database_config.storage_encrypted

  tags = {
    Name = var.database_config.instance_identifier
  }
}

