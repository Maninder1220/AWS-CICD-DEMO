# ROLE for Codebuild 
resource "aws_iam_role" "assume_role" {
  name = var.cicd_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  description = "Role for This CICD Stack includes CodeBuild, CodeDeploy, CodePipeline, Event Bridge"
}


data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = [
        "codebuild.amazonaws.com",
        "codedeploy.amazonaws.com",
        "codepipeline.amazonaws.com",
        "events.amazonaws.com"
        
      ]
    }
  }
}


resource "aws_iam_role_policy_attachment" "logs_policy_attachment" {
  role       = aws_iam_role.assume_role.name
  policy_arn = aws_iam_policy.logs_policy.arn
}


# ADDITIONAL POLICY FOR LOGS AND EVENT BRIDGE
resource "aws_iam_policy" "logs_policy" {
  name        = "my-logs-policy"
  policy      = data.aws_iam_policy_document.log_permissions_policy.json
}

data "aws_iam_policy_document" "log_permissions_policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "codedeploy:RegisterApplicationRevision",
      "codedeploy:GetDeployment",
      "codedeploy:GetApplication",
      "codedeploy:CreateDeployment",
      "codedeploy:GetDeploymentConfig",
      "codedeploy:GetApplicationRevision",
      "codepipeline:StartPipelineExecution",
      "codecommit:GetBranch",
      "codecommit:GetCommit",
      "codecommit:UploadArchive",
      "codecommit:GetUploadArchiveStatus",
      "codecommit:CancelUploadArchive",
      "s3:PutObject",
      "s3:GetObject",
      "codebuild:StartBuild",
      "codebuild:BatchGetBuilds",
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeRegions",
      "ec2:DescribeAvailabilityZones",
      "ec2:StartInstances",
      "ec2:StopInstances",
      "ec2:TerminateInstances",
      "ec2:CreateTags"
    ]

    resources = ["*"] 
  }
}