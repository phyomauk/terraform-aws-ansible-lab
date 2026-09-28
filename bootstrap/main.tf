# artifact s3 bucket
module "s3_artifacts" {
  source       = "./modules/s3"
  project_name = var.project_name
}

# create all required roles
module "iam_roles" {
  source                = "./modules/iam"
  project_name          = var.project_name
  artifacts_bucket_arn  = module.s3_artifacts.artifacts_bucket_arn
  codeconnections_id    = "5fd2ca39-3397-4cc2-bbe7-6c53deee9574"
}


