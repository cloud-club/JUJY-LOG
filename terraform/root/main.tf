module "codebuild" {
  source = "../modules/codebuild"
  tag    = var.tag
  #   branch_name         = var.branch
  #   commit_id           = module.codebuild.commit_id
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
  region              = var.REGION
  repo_name           = var.REPO_NAME
  user_name           = var.USER_NAME
}

module "codepipeline" {
  source            = "../modules/codepipeline"
  tag               = var.tag
  user_name         = var.USER_NAME
  repo_name         = var.REPO_NAME
  branch_name       = var.branch
  source_provider   = var.sourceP
  build_provider    = var.buildP
  codebuild_project = module.codebuild.aws_codebuild_project
}