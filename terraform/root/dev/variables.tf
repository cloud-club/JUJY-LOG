variable "env" {
  type        = string
  description = "name of env"
}

variable "code_repository" {
  type        = string
  description = "name of codecommit repository"
}

variable "name" {
  type        = string
  description = "name of iam user for credential"
}