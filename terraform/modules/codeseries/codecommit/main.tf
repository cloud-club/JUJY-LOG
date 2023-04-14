resource "aws_codecommit_repository" "jujy_log_repo" {
  repository_name = "${var.env}-${var.repo_name}"
  description     = "created by jujy"
  default_branch = "main"
}
