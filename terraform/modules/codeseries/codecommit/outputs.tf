output "repository_name" {
  value       = aws_codecommit_repository.jujy_log_repo.repository_id
  description = "repository id of codecommit"
}

output "http_clone_url" {
  value       = aws_codecommit_repository.jujy_log_repo.clone_url_http
  description = "http url to clone on local"
}
