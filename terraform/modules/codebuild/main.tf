# ECR repository
data "aws_ecr_repository" "jujy_ecr" {
  name = "zw-jujy-log"
}

# latest commit id
# resource "null_resource" "get_latest_commit_id" {
#   provisioner "local-exec" {
#     command = <<EOF
#       LATEST_COMMIT_ID=$(aws codecommit get-branch --repository-name ${var.repo_name} --branch-name ${var.branch_name} --query 'branch.commitId' --output text)
#       echo "latest_commit_id = \"${LATEST_COMMIT_ID}\"" > latest_commit_id.tfvars
#     EOF
#   }
# }

# codebuild project
resource "aws_codebuild_project" "jujy_codebuild_project" {
  name         = "${var.tag}-${var.repo_name}-project"
  description  = "project created by ${var.tag}"
  service_role = aws_iam_role.codebuild_service_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:5.0"
    type         = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = var.account_id
      type  = "PLAINTEXT"
    }

    environment_variable {
      name  = "REGION"
      value = var.region
      type  = "PLAINTEXT"
    }

    environment_variable {
      name  = "USER_NAME"
      value = var.user_name
      type  = "PLAINTEXT"
    }

    environment_variable {
      name  = "REPO_NAME"
      value = "${var.tag}-${var.repo_name}"
      type  = "PLAINTEXT"
    }
  }

  source {
    type            = "CODECOMMIT"
    location        = var.codecommit_http_url
    git_clone_depth = 1
    buildspec       = "configuration/buildspec.yml"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "${var.tag}-${var.repo_name}-logging-group"
      stream_name = "${var.tag}-${var.repo_name}-logging-stream"
    }
  }
}

