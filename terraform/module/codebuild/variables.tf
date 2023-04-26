variable "aws_default_region" {}
variable "aws_account_id" {}
variable "codebuild_project_name" {}
variable "ecr_repo_name" {}
variable "codecommit_repo_name" {}

#role/policy
variable "codebuild_role_name" {}
variable "codebuild_assume_role_policy_name" {}
variable "eks_kubectl_role_name" {}
variable "codebuild_base_policy_name" {}