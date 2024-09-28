output "code_commit_repository_one" {
  value = aws_codecommit_repository.repo_one.clone_url_http 
}