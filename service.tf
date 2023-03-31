resource "aws_ecs_task_definition" "api" {
  family                   = "${local.name}-api-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  task_role_arn            = aws_iam_role.ecs_task.arn
  container_definitions = <<DEFINITION
[
  {
    "name": "${local.name}-container",
    "logConfiguration": {
       "logDriver": "awslogs",
       "secretOptions": null,
       "options": {
         "awslogs-group": "${aws_cloudwatch_log_group.ecs-api.name}",
         "awslogs-region": "${data.aws_region.current.name}",
         "awslogs-stream-prefix": "ecs"
       }
     },
    
    "image": "752692907119.dkr.ecr.ap-south-1.amazonaws.com/node-api:latest",
    "essential": true,
    "environment":  ${jsonencode(local.env_vars_api)},
    "portMappings": [
        {
          "containerPort": 3000
        }
    ],
    "secrets": ${jsonencode(local.application_secrets)}
  }
]
DEFINITION

  tags = local.tags
}

resource "aws_ecs_service" "ecs_service_api" {
  name                               = "${local.name}-api-service"
  cluster                            = local.ecs_cluster_id
  task_definition                    = aws_ecs_task_definition.api.arn
  desired_count                      = 2
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  health_check_grace_period_seconds  = 60
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"

  network_configuration {
    security_groups  = [aws_security_group.ecs_service_api.id]
    subnets          = local.private_subnets
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = local.api_target_group_arn
    container_name   = "${local.name}-container"
    container_port   = 3000
  }

  # we ignore task_definition changes as the revision changes on deploy
  # of a new version of the application
  # desired_count is ignored as it can change due to autoscaling policy
  lifecycle {
    ignore_changes = [task_definition, desired_count]
  }
  propagate_tags = "SERVICE"
  tags = merge(local.tags, {
    Name  = "${local.name}-api-service"
  })
}


resource "aws_ecs_task_definition" "web" {
  family                   = "${local.name}-web-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  task_role_arn            = aws_iam_role.ecs_task.arn
  container_definitions = <<DEFINITION
[
  {
    "name": "${local.name}-container",
    "logConfiguration": {
       "logDriver": "awslogs",
       "secretOptions": null,
       "options": {
         "awslogs-group": "${aws_cloudwatch_log_group.ecs-web.name}",
         "awslogs-region": "${data.aws_region.current.name}",
         "awslogs-stream-prefix": "ecs"
       }
     },
    
    "image": "752692907119.dkr.ecr.ap-south-1.amazonaws.com/node-web:latest",
    "essential": true,
    "environment":  ${jsonencode(local.env_vars_web)},
    "portMappings": [
        {
          "containerPort": 3000
        }
    ]
  }
]
DEFINITION

  tags = local.tags
}

resource "aws_ecs_service" "ecs_service_web" {
  name                               = "${local.name}-web-service"
  cluster                            = local.ecs_cluster_id
  task_definition                    = aws_ecs_task_definition.web.arn
  desired_count                      = 2
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  health_check_grace_period_seconds  = 60
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"

  network_configuration {
    security_groups  = [aws_security_group.ecs_service_web.id]
    subnets          = local.private_subnets
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = local.web_target_group_arn
    container_name   = "${local.name}-container"
    container_port   = 3000
  }

  # we ignore task_definition changes as the revision changes on deploy
  # of a new version of the application
  # desired_count is ignored as it can change due to autoscaling policy
  lifecycle {
    ignore_changes = [task_definition, desired_count]
  }
  propagate_tags = "SERVICE"
  tags = merge(local.tags, {
    Name  = "${local.name}-web-service"
  })
}