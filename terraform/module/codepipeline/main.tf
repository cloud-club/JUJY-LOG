resource "aws_codepipeline" "codepipeline" {
  name     = var.codepipeline_name
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName = var.codecommit_repo_name
        BranchName       = "main"
      }
    }
  }

  stage {
    name = "Build_and_Deploy"

    action {
      name            = "Build"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["source_output"]
      output_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ProjectName = "tf-jujylog"
      }
    }
  }
}

# resource "aws_codestarconnections_connection" "codestar_connection" {
#   name          = "codecommit-codestar-connection"
#   provider_type = "CodeCommit"
# }

# s3
resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = var.s3_bucket_name
}

# resource "aws_s3_bucket_acl" "codepipeline_bucket_acl" {
#   bucket = aws_s3_bucket.codepipeline_bucket.id
#   acl    = "private"
# }

