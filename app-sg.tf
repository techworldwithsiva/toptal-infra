resource "aws_security_group" "ecs_service_api" {
  name   = "${local.name}-ecs-service"
  vpc_id = local.vpc_id

  ingress {
    protocol         = "tcp"
    from_port        = 3000
    to_port          = 3000
    security_groups = [local.api_security_group_id]
  }
  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
  
  }
  tags = merge(local.tags, {
    Name  = "${local.name}-ecs-service"
  })
}

resource "aws_security_group" "ecs_service_web" {
  name   = "${local.name}-ecs-web-service"
  vpc_id = local.vpc_id

  ingress {
    protocol         = "tcp"
    from_port        = 3000
    to_port          = 3000
    security_groups = [local.web_security_group_id]
  }
  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
  
  }
  tags = merge(local.tags, {
    Name  = "${local.name}-ecs-web-service"
  })
}

resource "aws_security_group_rule" "rds" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  source_security_group_id   = aws_security_group.ecs_service_api.id
  security_group_id = local.rds_security_group_id
}
