data "aws_acm_certificate" "existing" {
  domain   = var.site_domain
  statuses = ["ISSUED"]
}

resource "aws_ssm_parameter" "cert_arn" {
  name  = "/${var.project_name}/prod/certificate_arn"
  type  = "String"
  value = data.aws_acm_certificate.existing.arn
}