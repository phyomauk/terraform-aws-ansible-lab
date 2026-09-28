variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "alb_sg_id" {
  type = string
}

variable "certificate_arn" {
  type        = string
  description = "The ARN of the ACM SSL certificate for the HTTPS listener"
}

variable "web_instance_ids" {
  type        = list(string)
  description = "frontend web instances IDs"
}