output "codepipeline_role_arn" {
  value = aws_iam_role.codepipeline_role.arn
}

output "codebuild_role_arn" {
  value = aws_iam_role.codebuild_role.arn
}

output "tf_admin_role_arn" {
  value = aws_iam_role.tf_admin.arn
}
