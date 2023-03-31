resource "aws_ecr_repository" "web_repo" {
  name                 = var.web_repo
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
  tags = merge(local.tags, {
    Name = "node-web"
  })
}

resource "aws_ecr_repository" "api_repo" {
  name                 = var.api_repo
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
  tags = merge(local.tags, {
    Name = "node-api"
  })
}