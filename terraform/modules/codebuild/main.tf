# ECR repository
data "aws_ecr_repository" "jujy_ecr" {
  name = "zw-jujy-log"
}

# codebuild project
resource "aws_codebuild_project" "jujy_codebuild_project" {
  name         = "${var.repo_name}-project"
  description  = "project created by ${var.tag}"
  service_role = aws_iam_role.codebuild_service_role.arn
  
  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:5.0"
    type         = "LINUX_CONTAINER"
    # image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = var.account_id
      type  = "PLAINTEXT"
    }

    environment_variable {
      name  = "USER_NAME"
      value = var.user_name
      type  = "PLAINTEXT"
    }

    environment_variable {
      name  = "REPO_NAME"
      value = var.repo_name
      type  = "PLAINTEXT"
    }
  }

  source {
    type            = "CODECOMMIT"
    location        = var.codecommit_http_url
    git_clone_depth = 1

    buildspec = "configuration/buildspec.yml"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "${var.repo_name}-logging-group"
      stream_name = "${var.repo_name}-logging-stream"
    }
  }
}

