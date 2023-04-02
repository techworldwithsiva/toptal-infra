module "alb-api" {
  source = "terraform-aws-modules/alb/aws"
  name   = "toptal-api-alb"

  load_balancer_type = "application"
  vpc_id             = local.vpc_id
  subnets            = local.public_subnets
  security_groups    = ([local.api_security_group_id])
  create_security_group = false
  target_groups = [
    {
      name_prefix          = "api-"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "ip"
      deregistration_delay = 0
      health_check = {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = "5"
        path                = "/api/status"
        protocol            = "HTTP"
        interval            = 10
        matcher             = "200"
      }
    }
  ]
  target_group_tags = merge(local.tags, {
    Name = "toptal-api-alb"
  })

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = local.acm_certificate_arn
      target_group_index = 0
    }
  ]

  tags = local.tags
}

module "alb-web" {
  source = "terraform-aws-modules/alb/aws"
  name   = "toptal-api-web"

  load_balancer_type = "application"
  vpc_id             = local.vpc_id
  subnets            = local.public_subnets
  security_groups    = ([local.web_security_group_id])
  create_security_group = false
  target_groups = [
    {
      name_prefix          = "web-"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "ip"
      deregistration_delay = 0
      health_check = {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = "5"
        path                = "/health"
        protocol            = "HTTP"
        interval            = 10
        matcher             = "200"
      }
    }
  ]
  target_group_tags = merge(local.tags, {
    Name = "toptal-api-web"
  })

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      target_group_index = 0
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = local.acm_certificate_arn
      target_group_index = 0
    }
  ]

  tags = local.tags
}