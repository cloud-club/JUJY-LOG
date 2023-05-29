# resource "aws_s3_bucket" "codepipeline_bucket" {
#   bucket = "${var.tag}-${var.repo_name}-pipeline-bucket"
#   force_destroy = true
# }

data "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "codepipeline-zw-jujy-log"
}

resource "aws_codepipeline" "codepipeline" {
  name     = "${var.tag}-${var.repo_name}-pipeline"
  role_arn = aws_iam_role.codepipeline_service_role.arn

  # only support S3 currently
  artifact_store {
    location = data.aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = var.user_name
      provider         = var.source_provider
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName = "${var.tag}-${var.repo_name}"
        BranchName     = var.branch_name
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = var.user_name
      provider         = var.build_provider
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = var.codebuild_project
      }
    }
  }
}
