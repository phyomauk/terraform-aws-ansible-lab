output "artifacts_bucket_arn" {
  value = module.s3_artifacts.artifacts_bucket_arn
}

output "codebuild_role_arn" {
  value = module.iam_roles.codebuild_role_arn
}

output "codepipeline_role_arn" {
  value = module.iam_roles.codepipeline_role_arn
}

output "tf_admin_role_arn" {
  value = module.iam_roles.tf_admin_role_arn
}

output "ec2_ssm_profile_name" {
  value = module.iam_roles.ec2_ssm_profile_name
}