output "code_deploy_app_name" {
    value = aws_codedeploy_app.app.name
}

output "cd_app_id" {
    value = aws_codedeploy_app.app.id
}