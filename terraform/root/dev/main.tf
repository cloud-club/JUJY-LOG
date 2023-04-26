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

module "eks" {
  source                  = "../../module/eks"
  aws_account_id          = var.aws_account_id
  aws_default_region      = var.aws_default_region
  eks_cluster_name        = var.eks_cluster_name
  eks_kubectl_role_name   = var.eks_kubectl_role_name
  eks_kubectl_policy_name = var.eks_kubectl_policy_name
  #manifest
  codebuild_role_name          = var.codebuild_role_name
  eks_cluster_config_file_path = var.eks_cluster_config_file_path
  k8s_deployment_file_path     = var.k8s_deployment_file_path
  k8s_service_file_path        = var.k8s_service_file_path
  k8s_ingress_file_path        = var.k8s_ingress_file_path
}

module "codebuild" {
  depends_on = [
    module.ecr, module.eks
  ]
  source                 = "../../module/codebuild"
  aws_account_id         = var.aws_account_id
  aws_default_region     = var.aws_default_region
  ecr_repo_name          = var.ecr_repo_name
  codecommit_repo_name   = var.codecommit_repo_name
  codebuild_project_name = var.codebuild_project_name
  #role/policy
  codebuild_role_name               = var.codebuild_role_name
  codebuild_assume_role_policy_name = var.codebuild_assume_role_policy_name
  codebuild_base_policy_name        = var.codebuild_base_policy_name
  eks_kubectl_role_name             = var.eks_kubectl_role_name
}

module "codepieline" {
  depends_on = [
    module.codebuild
  ]
  source                        = "../../module/codepipeline"
  codepipeline_name             = var.codepipeline_name
  codepipeline_role_name        = var.codepipeline_role_name
  codepipeline_role_policy_name = var.codepipeline_role_policy_name
  codecommit_repo_name          = var.codecommit_repo_name
  s3_bucket_name                = var.s3_bucket_name
}





