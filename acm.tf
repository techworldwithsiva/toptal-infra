module "acm" {
  source = "terraform-aws-modules/acm/aws"

  domain_name = "*.techietrainers.com"
  zone_id     = "Z069840220Z2G1MXQRMAA"

  subject_alternative_names = [
    "*.techietrainers.com"
  ]

  wait_for_validation = true

  tags = merge(local.tags, {
    Name = "techietrainers.com"
  })
}

module "web_alb_cdn" {
  source  = "terraform-aws-modules/acm/aws"

  domain_name  = local.web_alb_cdn_fqdn
  zone_id      = var.zone_id

  subject_alternative_names = [local.web_alb_cdn_fqdn]

  wait_for_validation = true

  tags = merge(local.tags, {
    Name  = "web-cdn"
  })
  providers = {
    aws = aws.us-east-1-cdn
  }
}