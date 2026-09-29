# artifact s3 bucket
module "s3_artifacts" {
  source       = "./modules/s3"
  project_name = var.project_name
}

# create all required roles
module "iam_roles" {
  source               = "./modules/iam"
  project_name         = var.project_name
  artifacts_bucket_arn = module.s3_artifacts.artifacts_bucket_arn
  codeconnections_id   = "5fd2ca39-3397-4cc2-bbe7-6c53deee9574"
}

# ssm parameter store
# module "ssm_parameter_store" {
#   source                = "./modules/parameterstore_prod"
#   project_name          = var.project_name
#   hosted_zone_id        = var.hosted_zone_id
#   domain_name           = var.domain_name
#   site_full_domain_name = var.site_full_domain_name
#   aws_region            = var.aws_region
#   repo_owner            = var.repo_owner
#   repo_name             = var.repo_name
#   codeconnections_arn   = var.codeconnections_arn
#   state_bucket_name     = var.state_bucket_key
#   state_bucket_key      = var.state_bucket_key
#   email_address         = var.email_address

# }
