variable "tag" {
  type        = string
  description = "prefix tag"
}

variable "codecommit_url" {
  type        = string
  description = "codecommit repository clone url"
  sensitive   = true
}

variable "log_resource" {
  type      = list(string)
  sensitive = true
}

variable "logs_actions" {
  type        = list(string)
  description = "list of actions related to logging"
}

variable "s3_resource" {
  type      = string
  sensitive = true
}

variable "s3_actions" {
  type        = list(string)
  description = "list of actions related to s3"
}

variable "codecommit_resource" {
  type      = string
  sensitive = true
}

variable "codecommit_actions" {
  type        = string
  description = "list of actions related to codecommit"
}

variable "codebuild_resource" {
  type      = string
  sensitive = true
}

variable "codebuild_actions" {
  type        = list(string)
  description = "list of actions related to codebuild"
}

variable "AWS_ACCOUNT_ID" {
  type      = number
  sensitive = true
}

variable "REGION" {
  type      = string
  sensitive = true
}

variable "USER_NAME" {
  type      = string
  sensitive = true
}

variable "REPO_NAME" {
  type      = string
  sensitive = true
}

variable "branch" {
  type        = string
  description = "branch name of codecommit repository"
}

variable "sourceP" {
  type        = string
  description = "source provider defined at codepipeline"
}

variable "buildP" {
  type        = string
  description = "build provider defined at codepipeline"
}
