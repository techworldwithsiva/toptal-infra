resource "aws_ssm_parameter" "vpc_id" {
  name        = "/toptal/vpc/vpc_id"
  description = "TOPTAL PROD VPC ID"
  type        = "String"
  value       = local.vpc_id
  tags = local.tags
}
  
resource "aws_ssm_parameter" "api_alb_security_group_id" {
  name        = "/toptal/api-alb/security_group_id"
  type        = "String"
  value       = local.api_security_group_id
  tags = local.tags
}

resource "aws_ssm_parameter" "web_alb_security_group_id" {
  name        = "/toptal/api-web/security_group_id"
  type        = "String"
  value       = local.web_security_group_id
  tags = local.tags
}

resource "aws_ssm_parameter" "rds_security_group_id" {
  name        = "/toptal/rds/security_group_id"
  type        = "String"
  value       = local.rds_security_group_id
  tags = local.tags
}

resource "aws_ssm_parameter" "rds_secret_arn" {
  name        = "/toptal/rds/rds_secret_arn"
  type        = "String"
  value       = local.rds_secret_arn
  tags = local.tags
}

resource "aws_ssm_parameter" "rds_endpoint" {
  name        = "/toptal/rds/rds_endpoint"
  type        = "String"
  value       = local.rds_endpoint
  tags = local.tags
}

resource "aws_ssm_parameter" "ecs_cluster_id" {
  name        = "/toptal/rds/ecs_cluster_id"
  type        = "String"
  value       = local.ecs_cluster_id
  tags = local.tags
}

resource "aws_ssm_parameter" "api_target_group_arn" {
  name        = "/toptal/alb/api_target_group_arn"
  type        = "String"
  value       = local.api_target_group_arn
  tags = local.tags
}