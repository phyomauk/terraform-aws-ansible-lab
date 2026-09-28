# Fetch latest Ubuntu 24.04 LTS AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-resolute-26.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  owners = ["099720109477"] # Canonical
}

# 1. Bastion Host (Public Subnet)
resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_ids[0]
  vpc_security_group_ids      = [var.bastion_sg_id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  tags = {
    Name        = "${var.project_name}-bastion"
    Role        = "bastion"
    Environment = "lab"
  }
}

# 2. Frontend Servers (Private Subnets - 2 instances)
resource "aws_instance" "frontend" {
  count                  = 2
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_ids[count.index % length(var.private_subnet_ids)]
  vpc_security_group_ids = [var.frontend_sg_id]
  key_name               = var.key_name

  tags = {
    Name        = "${var.project_name}-frontend-${count.index + 1}"
    Role        = "webservers"
    Environment = "lab"
  }
}

# 3. Database Server (DB Subnet - MySQL)
resource "aws_instance" "db" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.db_subnet_ids[0]
  vpc_security_group_ids = [var.db_sg_id]
  key_name               = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              # Create a 2GB swap file to prevent memory thrashing on t3.micro
              if [ ! -f /swapfile ]; then
                fallocate -l 2G /swapfile || dd if=/dev/zero of=/swapfile bs=1M count=2048
                chmod 600 /swapfile
                mkswap /swapfile
                swapon /swapfile
                echo '/swapfile none swap sw 0 0' >> /etc/fstab
              fi
              EOF

  # Ensure swap is created before Terraform considers the instance ready
  user_data_replace_on_change = true

  tags = {
    Name        = "${var.project_name}-mysql-db"
    Role        = "dbservers"
    Environment = "lab"
  }
}