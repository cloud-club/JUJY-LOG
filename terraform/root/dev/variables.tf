# setting
variable "aws_account_id" {
  type        = string
  description = "aws activated account"
}

variable "aws_default_region" {
  type        = string
  description = "aws defulat region"
}

#ecr
variable "ecr_repo_name" {
  type        = string
  description = "name of the ecr repo"
}

#codebuild



#codepipeline