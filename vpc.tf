module "vpc" {
  source           = "terraform-aws-modules/vpc/aws"
  name             = local.name
  cidr             = var.cidr
  azs              = ["${local.region}a", "${local.region}b"]
  private_subnets  = var.private_subnets
  public_subnets   = var.public_subnets
  database_subnets = var.database_subnets

  create_database_subnet_group = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  single_nat_gateway = true

  default_vpc_enable_dns_hostnames = true
  enable_dhcp_options              = true
  #dhcp_options_domain_name         = "${local.region}.${var.private_domain_name}"
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  default_network_acl_tags   = { Name = "${local.name}-default" }
  manage_default_network_acl = true

  manage_default_route_table = true
  default_route_table_tags   = { Name = "${local.name}-default" }

  manage_default_security_group = true
  default_security_group_tags   = { Name = "${local.name}-default" }
  default_security_group_name   = "${local.name}-default"
  database_subnet_tags          = { Name = "database-subnet-${local.name}" }
  # public_subnet_tags = { Name = "public-subnet-${local.name}" }
  # private_subnet_tags = { Name = "private-subnet-${local.name}" }

  private_subnet_tags_per_az = {
    az1 = {
      Name = "${data.aws_availability_zones.available.names[0]}-private-subnet-${local.name}"

    }
    az2 = {
      Name = "${data.aws_availability_zones.available.names[1]}-private-subnet-${local.name}"
    }
  }

  public_subnet_tags_per_az = {
    az1 = {
      Name = "${data.aws_availability_zones.available.names[0]}-public-subnet-${local.name}"

    }
    az2 = {
      Name = "${data.aws_availability_zones.available.names[1]}-public-subnet-${local.name}"
    }
  }

  tags = local.tags
}
