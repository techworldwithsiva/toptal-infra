module "db" {
    source  = "terraform-aws-modules/rds/aws"
    identifier = "${local.name}"
    engine               = "postgres"
    engine_version       = "14"
    family               = "postgres14" # DB parameter group
    major_engine_version = "14"         # DB option group
    instance_class       = "db.t4g.micro"
    allocated_storage     = 20
    max_allocated_storage = 100

    db_name  = "node_app"
    username = "developer"
    port     = 5432
    multi_az               = false
    db_subnet_group_name   = local.database_subnet_group_name
    vpc_security_group_ids = [local.rds_security_group_id]
    create_cloudwatch_log_group     = true
    backup_retention_period = 3
    publicly_accessible = true
    create_random_password = false
    password                = random_password.master.result
    tags = local.tags
}

resource "random_password" "master"{
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "password" {
  name = "totpal/student/rds-password"
  recovery_window_in_days = 0
  tags = local.tags
}

resource "aws_secretsmanager_secret_version" "password" {
  secret_id = aws_secretsmanager_secret.password.id
  secret_string = random_password.master.result
}