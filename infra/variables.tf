variable "project_name" {
  default = "ansible-lab"
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
  description = "your site domain, not top level name"
  default     = "*.phyomauk.click"
}