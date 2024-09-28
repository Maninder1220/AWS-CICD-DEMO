resource "aws_codecommit_repository" "repo_one" {
  repository_name = var.repo-one-name
  description = "This is Mahitys Repo"
}