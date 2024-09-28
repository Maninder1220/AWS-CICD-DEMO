# ROLE for Codebuild 
resource "aws_iam_role" "assume_role" {
  name = var.cicd_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  description = "Role for This CICD Stack includes CodeBuild, CodeDeploy, CodePipeline"
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
        
      ]
    }
  }
}


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
      "codedeploy:GetApplication"
    ]

    resources = ["*"] 
  }
}