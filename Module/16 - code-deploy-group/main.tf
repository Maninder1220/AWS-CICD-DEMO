# code deploy group
resource "aws_codedeploy_deployment_group" "deployment_group_one" {
deployment_group_name = var.deployment_group_one
app_name = var.code_deploy_app_name
service_role_arn = var.assume_role_arn
deployment_config_name = "CodeDeployDefault.HalfAtATime"

auto_rollback_configuration {
    enabled = true
    events = ["DEPLOYMENT_FAILURE"]
}

ec2_tag_set {
    ec2_tag_filter {
      key   = "CodeDeploy"
      value = "MyCdEC2Instance"
      type  = "KEY_AND_VALUE"
    }
}
depends_on = [ var.cd_app_id ]
}