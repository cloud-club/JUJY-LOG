resource "aws_codebuild_project" "codebuild_project" {

  name = var.codebuild_project_name
  service_role = aws_iam_role.codebuild_role.arn

  environment {

    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name = "AWS_DEFAULT_REGION" 
      value = var.aws_default_region
    }

    environment_variable {
      name = "AWS_ACCOUNT_ID" 
      value = var.aws_account_id
    }

    environment_variable {
      name = "IMAGE_REPO_NAME" 
      value = var.ecr_repo_name
    }

    environment_variable {
      name = "EKS_KUBECTL_ROLE_ARN" 
      value = "arn:aws:iam::${var.aws_account_id}:role/${var.eks_kubectl_role_name}"
    }
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
  }

  source {
    type            = "CODECOMMIT"
    location        = var.codecommit_repo_name
    git_clone_depth = 1
    buildspec = "aws/buildspec.yml"
  }
}
