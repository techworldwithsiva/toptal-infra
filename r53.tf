module "alb-api-r53" {
  source = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = var.zone_name
  records = [
    {
      name = var.record_name_api
      type = "A"
      alias = {
        name    = local.api_alb_dns_name
        zone_id = local.api_alb_zone_id
      }
    }
  ]
}

module "alb-web-r53" {
  source = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = var.zone_name
  records = [
    {
      name = var.record_name_web
      type = "A"
      alias = {
        name    = local.web_alb_dns_name
        zone_id = local.web_alb_zone_id
      }
    }
  ]

}

module "alb_cdn_r53" {
  source  = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = var.zone_name
  records = [
    {
      name    = var.record_name_web_alb_cdn
      type    = "A"
      alias   = {
        name    = local.cloudfront_distribution_domain_name
        zone_id = local.cloudfront_distribution_hosted_zone_id
      }
    }
  ]
}