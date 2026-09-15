output "bastion_public_ip" {
  value       = aws_instance.bastion.public_ip
  description = "Public IP of the bastion host for SSH connection"
}

output "frontend_private_ips" {
  value       = aws_instance.frontend[*].private_ip
  description = "Private IPs of the frontend servers"
}

output "db_private_ip" {
  value       = aws_instance.db.private_ip
  description = "Private IP of the MySQL database server"
}