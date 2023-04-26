# ======================== setting ========================
variable "aws_account_id" {
  type        = string
  description = "aws activated account"
}

variable "aws_default_region" {
  type        = string
  description = "aws defulat region"
}


# ======================== ecr ========================
variable "ecr_repo_name" {
  type        = string
  description = "name of the ecr repo"
}


# ======================== eks ========================
variable "eks_cluster_name" {
  type        = string
  description = "name of the eks cluster"
}

variable "eks_kubectl_role_name" {
  type        = string
  description = "name of the eks kubectl role"
}

variable "eks_kubectl_policy_name" {
  type        = string
  description = "name of the eks kubectl policy"
}

variable "eks_cluster_config_file_path" {
  type        = string
  description = "path of the eks cluster config file"
}

variable "k8s_deployment_file_path" {
  type        = string
  description = "path of the k8s deployment.yml file"
}

variable "k8s_service_file_path" {
  type        = string
  description = "path of the k8s service.yml file"
}

variable "k8s_ingress_file_path" {
  type        = string
  description = "path of the k8s ingress.yml file"
}


# ======================== codebuild ========================
variable "codebuild_project_name" {
  type        = string
  description = "name of the codebuild project"
}

variable "codebuild_role_name" {
  type        = string
  description = "name of the codebuild role"

}
variable "codebuild_assume_role_policy_name" {
  type        = string
  description = "name of the codebuild assume role policy"

}
variable "codebuild_base_policy_name" {
  type        = string
  description = "name of the codebuild base policy"
}

variable "codecommit_repo_name" {
  type        = string
  description = "name of codecommit repo"
}


# ======================== codepipeline ========================
variable "codepipeline_name" {
  type        = string
  description = "name of codepipeline pipeline"
}

variable "codepipeline_role_name" {
  type        = string
  description = "name of the codepipeline role"
}

variable "codepipeline_role_policy_name" {
  type        = string
  description = "name of the codepieline role policy"
}

variable "s3_bucket_name" {
  type        = string
  description = "name of the s3 bucket"
}