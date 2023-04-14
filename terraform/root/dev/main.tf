# terraform {
#   backend "s3" {
#     bucket         = "terraform-remote-state-jujy-log"
#     key            = "dev/terraform.tfstate"
#     region         = "ap-northeast-2"
#     dynamodb_table = "TerraformStateLock"
#     encrypt        = true
#   }
# }

module "codecommit" {
  source    = "../../modules/codeseries/codecommit"
  env       = var.env
  repo_name = var.code_repository
}