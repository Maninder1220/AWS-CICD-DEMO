# AWS-CICD-DEMO
Purely AWS CICD DEMO

# REMOVE MANUALLY
aws s3 rm s3://my-artifact-and-logs-bucket-for-code-pipeline --recursive

# MY HUGE ASSUME ROLE POLICY
# MISSELANIOUS POLICY
resource "aws_iam_role_policy_attachment" "logs_policy_attachment" {
  role       = aws_iam_role.assume_role.name
  policy_arn = aws_iam_policy.logs_policy.arn
}

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

# CODEPIPELINE Theory
- Pipeline have Stages
- Stages have actions
- Actions have Name, Category, Owner, Provider
  Input_Artifacts, Output_Artifacts, Configuration and version
