terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "timing-backend-s3"
    key    = "vpc1"
    region = "ap-south-1"
    dynamodb_table = "timing-lock"
  }
}

provider "aws" {
  region = "ap-south-1"
}

provider "aws" {
  region = "us-east-1"
  alias =   "us-east-1-cdn"
}

