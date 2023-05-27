output "aws_codebuild_project" {
  value = aws_codebuild_project.jujy_codebuild_project.id
}

# output "commit_id" {
#   value = null_resource.get_latest_commit_id.id
# }