variable "project_name" {
  default = "ansible-aws-lab"
}

variable "aws_region" {
  default = "us-west-1"
}


variable "vpc_cidr" {
  default = "10.10.0.0/16"
}

# variable "my_ips" {
#   description = "ansible controller IP address"
#   type        = list(string)
# }

variable "ec2-public-key" {
  description = "ec2 key paris name"
}

variable "site_domain" {
  description = "your site domain name to retrieve the certificate from ACM"
  default     = "*.phyomauk.click"
}

variable "domain_name" {
  description = "fully qualified domain name"
  default     = "phyomauk.click"
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone ID"
}

variable "state_bucket_name" {

}

variable "state_bucket_key" {

}