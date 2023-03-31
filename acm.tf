module "acm" {
  source = "terraform-aws-modules/acm/aws"

  domain_name = "techietrainers.com"
  zone_id     = "Z069840220Z2G1MXQRMAA"

  subject_alternative_names = [
    "*.techietrainers.com"
  ]

  wait_for_validation = true

  tags = merge(local.tags, {
    Name = "techietrainers.com"
  })
}