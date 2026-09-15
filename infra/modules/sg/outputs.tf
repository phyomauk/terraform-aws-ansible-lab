output "alb_sg_id" {
  value = aws_security_group.alb.id
}

output "frontend_sg_id" {
  value = aws_security_group.frontend.id
}

output "db_sg_id" {
  value = aws_security_group.db.id
}

output "bastion_sg_id" {
  value = aws_security_group.bastion.id
}