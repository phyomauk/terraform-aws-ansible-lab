variable "project_name" {
  default = "ansible-aws-lab"
}

variable "aws_region" {
  default = "us-west-1"  
}


variable "vpc_cidr" {
  default = "10.10.0.0/16"
}

variable "my_ip" {
  description = "your home ip address"
}

variable "ec2-public-key" {
  description = "ssh public key name"
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