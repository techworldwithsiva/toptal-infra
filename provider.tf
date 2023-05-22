terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.60.0"
    }
    http = {
      source = "hashicorp/http"
      version = "~> 2.1"
    }
  }

  backend "s3" {
    bucket = "timing-backend-s3"
    key    = "vpc"
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

provider "http" {
}