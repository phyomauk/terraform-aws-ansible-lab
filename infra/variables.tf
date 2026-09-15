variable "project_name" {
  default = "ansible-lab"
}

variable "vpc_cidr" {
  default = "10.10.0.0/16"
}

variable "my_ip" {
  description = "your home ip address"
  default     = "47.152.151.252/32"
}

variable "ec2-public-key" {
  description = "ssh public key name"
}