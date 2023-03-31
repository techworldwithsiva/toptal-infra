locals {
  name   = "toptal-student"
  region = "ap-south-1"
  tags = {
    Terraform = "true"
    Environment = "PROD"
    System = "toptal"
    Component = "student"
    Type = "infra"
  }
}

locals{
    vpc_id = module.vpc.vpc_id
    public_subnets = module.vpc.public_subnets
    # public_subnet_id_azA = split(",", module.vpc.public_subnets.value)[0]
    # public_subnet_id_azB = split(",", module.vpc.public_subnets.value)[1]
    private_subnets = module.vpc.private_subnets
    database_subnet_group_name = module.vpc.database_subnet_group_name
    rds_security_group_id = module.rds-sg.security_group_id
    /* eks_managed_node_groups_autoscaling_group_names = module.eks.eks_managed_node_groups_autoscaling_group_names
    node_security_group_id = module.eks.node_security_group_id */
    api_security_group_id = module.alb-api-sg.security_group_id
    web_security_group_id = module.alb-web-sg.security_group_id
    acm_certificate_arn=module.acm.acm_certificate_arn
    api_alb_dns_name = module.alb-api.lb_dns_name
    web_alb_dns_name = module.alb-web.lb_dns_name
    api_alb_zone_id = module.alb-api.lb_zone_id
    web_alb_zone_id = module.alb-web.lb_zone_id
    rds_secret_arn=aws_secretsmanager_secret.password.arn
    rds_endpoint=split(":",module.db.db_instance_endpoint)[0]
    ecs_cluster_id = module.ecs.cluster_id
    api_target_group_arn=join(",", module.alb-api.target_group_arns)
  
    web_target_group_arn=join(",", module.alb-web.target_group_arns)

    application_secrets = [
    {
        "name": "DBPASS"
        "valueFrom" : "${local.rds_secret_arn}"
    }
  ]

  env_vars_api = [
    {
      "name" : "DBUSER",
      "value" : "developer"
    },
    {
      "name" : "DB",
      "value" : "node_app"
    },
    {
    "name" : "DBHOST",
    "value": "${local.rds_endpoint}"
    },
    {
    "name" : "DBPORT",
    "value": "5432"
    }
  ]
  env_vars_web = [
    {
      "name" : "PORT",
      "value" : "3000"
    },
    {
      "name" : "API_HOST",
      "value" : "https://api.techietrainers.com"
    }
  ]
}

/* output "eks_managed_node_groups_autoscaling_group_names" {
  description = "List of the autoscaling group names created by EKS managed node groups"
  value       = module.eks.eks_managed_node_groups_autoscaling_group_names
} */

data "aws_availability_zones" "available" {}

output "rds_endpoint" {
  value = local.rds_endpoint
}



data "aws_iam_policy_document" "ecs_trust" {
  statement {
    actions = ["sts:AssumeRole"]
    sid       = "ECSAssumeRole"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "rds_secret" {
  statement {
    sid       = "AllowECSTask"
    actions   = [
                "secretsmanager:GetSecretValue"
            ]
    resources = ["${local.rds_secret_arn}"]
  }
}
data "aws_region" "current" {}