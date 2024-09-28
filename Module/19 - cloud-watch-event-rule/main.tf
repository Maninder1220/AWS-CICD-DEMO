resource "aws_cloudwatch_event_rule" "code_commit_event_rule" {
    name        = var.cc_trigger_codepipeline
    description = "Trigger CodePipeline on CodeCommit push events"
    
    event_pattern = jsonencode({
    "source"   : ["aws.codecommit"],
    "detail-type": ["CodeCommit Repository State Change"],
    "resources" : ["arn:aws:codecommit:ap-south-1:767397677463:mahity-repo-one"],
    "detail": {
      "event": ["referenceUpdated"],
      "referenceType": ["branch"],
      "referenceName": ["main"]
      }
      })
}