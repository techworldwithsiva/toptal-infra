variable "cidr" {
  type    = string
  default = "10.120.0.0/16"
}
/* variable "private_domain_name" {
  default = "ap-south-1.totpal-production.local"
  type = string
} */

variable "private_subnets" {
  type    = list(string)
  default = ["10.120.1.0/24", "10.120.2.0/24"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.120.11.0/24", "10.120.12.0/24"]
}

variable "database_subnets" {
  type    = list(string)
  default = ["10.120.21.0/24", "10.120.22.0/24"]
}

variable "web_repo" {
  default = "node-web"
}

variable "api_repo" {
  default = "node-api"
}

variable "scan_on_push" {
  type    = bool
  default = false
}

variable "zone_name" {
  type    = string
  default = "techietrainers.com"
}

variable "zone_id" {
  type = string
  default = "Z069840220Z2G1MXQRMAA"
}
variable "record_name_api" {
  type    = string
  default = "api"
}

variable "record_name_web" {
  type    = string
  default = "web"
}

variable "record_name_web_alb_cdn" {
  type = string
  default = "web-cdn"
}