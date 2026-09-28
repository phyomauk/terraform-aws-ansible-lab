############################################
# CODEBUILD ROLE
############################################

resource "aws_iam_role" "codebuild_role" {
  name = "${var.project_name}-codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "codebuild.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "codebuild_assume_tf_admin" {
  name = "${var.project_name}-codebuild-assume-tf-admin"
  role = aws_iam_role.codebuild_role.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "sts:AssumeRole"
        Resource = aws_iam_role.tf_admin.arn
      }
    ]
  })
}

resource "aws_iam_policy" "codebuild_policy" {
  name = "${var.project_name}-codebuild-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [

      ############################################
      # S3 (pipeline artifacts)
      ############################################
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:GetObjectVersion"
        ]
        Resource = [
          "${var.artifacts_bucket_arn}/*"
        ]
      },

      ############################################
      # CloudWatch Logs
      ############################################
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },

      ############################################
      # (Optional) VPC (if using private build)
      ############################################
      {
        Effect = "Allow"
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface"
        ]
        Resource = "*"
      }
  
      ############################################
      # Allow read ssm parameter store
      ############################################
      # {
      #   Effect  = "Allow"
      #   Action  = [
      #     "ssm:GetParameter",
      #     "ssm:GetParameters"
      #   ]
      #   Resource = "arn:aws:ssm:${data.aws_region.current}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/prod/*"
      # }

    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_attach" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_policy.arn
}