resource "aws_cloudwatch_log_group" "codebuild_log_group" {
  name              = "/aws/codebuild/my-build/cicd/logs" 
  retention_in_days = 14    # Retain logs for 14 days
}