module "codebuild" {
  source              = "../modules/codebuild"
  tag                 = var.tag
  log_resource        = var.log_resource
  logs_actions        = var.logs_actions
  s3_resource         = var.s3_resource
  s3_actions          = var.s3_actions
  codecommit_resource = var.codecommit_resource
  codecommit_actions  = var.codecommit_actions
  codebuild_resource  = var.codebuild_resource
  codebuild_actions   = var.codebuild_actions
  codecommit_http_url = var.codecommit_url
  account_id          = var.AWS_ACCOUNT_ID
  repo_name           = var.REPO_NAME
  user_name           = var.USER_NAME
}