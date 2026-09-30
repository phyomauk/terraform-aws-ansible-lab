resource "aws_codebuild_project" "this" {
  name          = "${var.project_name}-playbook"
  description   = "Build project to execute Ansible playbooks via CodeBuild"
  service_role  = var.codebuild_role_arn
  build_timeout = 15

  artifacts {
    type = "CODEPIPELINE"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspecs/ansible/buildspec.yml"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0" # Ubuntu-based standard image with Python/AWS CLI pre-installed
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "TF_ADMIN_ROLE_ARN"
      value = var.tf_admin_role_arn
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = aws_cloudwatch_log_group.codebuild_ansible.name
      stream_name = "build-log"
    }
  }
}

resource "aws_cloudwatch_log_group" "codebuild_ansible" {
  name              = "/aws/${var.project_name}/codebuild/ansible"
  retention_in_days = 30
}