variable "project_name" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  description = "Name of the AWS SSH key pair to use for instances"
  type        = string
}

# Subnets from Networking Module
variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "db_subnet_ids" {
  type = list(string)
}

# Security Groups from SG Module
# variable "bastion_sg_id" {
#   type = string
# }

variable "frontend_sg_id" {
  type = string
}

variable "db_sg_id" {
  type = string
}

variable "ec2_ssm_profile_name" {
  type = string
}
