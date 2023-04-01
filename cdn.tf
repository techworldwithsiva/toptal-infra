module "cdn" {
  source = "terraform-aws-modules/cloudfront/aws"
  aliases = ["${var.record_name_web_alb_cdn}.${var.zone_name}"]
  comment = "Cloudfront to server WEB ALB"
  origin = {
      web-alb = {
        domain_name = local.web_alb_dns_name
        custom_origin_config = {
            http_port              = 80
            https_port             = 443
            origin_protocol_policy = "https-only"
            origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
        }
      }
  }

  default_cache_behavior = {
    target_origin_id       = "web-alb"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
  }
  viewer_certificate = {
    acm_certificate_arn = local.cdn_certificate_arn
    ssl_support_method  = "sni-only"
    minimum_protocol_version = "TLSv1_2016"
  }
  enabled             = true
  is_ipv6_enabled     = true

  geo_restriction = {
    restriction_type = "none"
  }
  tags = merge(local.tags, {
    Name  = "toptal-web-alb"
  })
}