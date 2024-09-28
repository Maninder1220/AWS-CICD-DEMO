# code deploy application
resource "aws_codedeploy_app" "app" {
  compute_platform = "Server"   # ECS or Lambda - Need Clarity Here
  name             = var.code_deploy_app_name
  depends_on = [ var.ec2_id ]
}