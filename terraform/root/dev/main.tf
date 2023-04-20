terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.aws_default_region
}

module "ecr" {
  source        = "../../module/ecr"
  ecr_repo_name = var.ecr_repo_name
}

module "codebuild" {
  depends_on = [
    module.ecr
  ]
  source             = "../../module/codebuild"
  aws_account_id     = var.aws_account_id
  aws_default_region = var.aws_default_region
  ecr_repo_name      = var.ecr_repo_name
}





