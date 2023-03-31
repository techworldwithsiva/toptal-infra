

module "rds-sg" {
  source          = "terraform-aws-modules/security-group/aws"
  name            = "totpal-student-rds"
  description     = "Security group which is used to attach to RDS"
  vpc_id          = local.vpc_id
  use_name_prefix = false
  ingress_with_source_security_group_id = [

  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all outbound"
      cidr_blocks = "0.0.0.0/0"

    },
  ]
  tags = merge(local.tags, {
    Name = "toptal-student-rds"
  })
}

module "alb-api-sg" {
  source          = "terraform-aws-modules/security-group/aws"
  name            = "node-api-alb"
  description     = "Security group which is used to attach to API ALB"
  vpc_id          = local.vpc_id
  use_name_prefix = false
  ingress_with_cidr_blocks = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = 6
      description = "Allow 443 from internet"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = 6
      description = "Allow 80 from internet"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all outbound"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  tags = merge(local.tags, {
    Name = "node-api-alb"
  })
}

module "alb-web-sg" {
  source          = "terraform-aws-modules/security-group/aws"
  name            = "node-web-alb"
  description     = "Security group which is used to attach to Web ALB"
  vpc_id          = local.vpc_id
  use_name_prefix = false
  ingress_with_cidr_blocks = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = 6
      description = "Allow 443 from internet"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all outbound"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  tags = merge(local.tags, {
    Name = "node-web-alb"
  })
}

/* module "node-sg" {
    source = "./modules/terraform-aws-security-group"
    name = "totpal-student-rds"
    description = "Security group which is used to attach to EKS n"
    vpc_id      = local.vpc_id
    use_name_prefix = false
    ingress_with_source_security_group_id  = [

    ]
    egress_with_cidr_blocks = [
        {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        description = "Allow all outbound"
        cidr_blocks  = "0.0.0.0/0"
        
        },
    ]
    tags = merge(local.tags, {
        Name  = "toptal-student-rds"
    })
} */

