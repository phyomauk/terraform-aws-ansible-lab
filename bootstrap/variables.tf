variable "project_name" {
  type    = string
  default = "ansible-aws-lab"
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone ID"
}

variable "domain_name" {
  description = "fully qualified domain name"
}

variable "site_full_domain_name" {
  description = "the web application site domain name"
}

variable "aws_region" {
  description = "aws region"
  default     = "us-west-1"
}

variable "repo_owner" {
  description = "repository owner name"
}

variable "codeconnections_arn" {
  description = "AWS codeconnections_arn for GitHub"
}

variable "repo_name" {
  description = "ansbile-aws-lab GitHub repo name"
}

variable "state_bucket_name" {

}

variable "state_bucket_key" {

}

variable "email_address" {

}