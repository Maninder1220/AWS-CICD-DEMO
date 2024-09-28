resource "aws_cloudwatch_event_target" "example" {
    rule      = var.event_rule_name
    target_id = "codepipeline"
    arn       = var.code_pipeline_arn
    role_arn  = var.assume_role_arn
}