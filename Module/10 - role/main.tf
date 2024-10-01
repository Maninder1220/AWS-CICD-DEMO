# ASSUMED ROLE
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
        "events.amazonaws.com",
        "ec2.amazonaws.com"

        
      ]
    }
  }
}

# NECESSARY AUTOMATION POLICIES FOR ASSUMED ROLE
# EC2 POLICY
resource "aws_iam_role_policy_attachment" "ec2_policy_attachment" {
  role       = aws_iam_role.assume_role.name
  policy_arn = aws_iam_policy.ec2_policy.arn
}

resource "aws_iam_policy" "ec2_policy" {
  name        = "my-ec2-policy"
  policy      = data.aws_iam_policy_document.ec2_policy.json
}

data "aws_iam_policy_document" "ec2_policy" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeRegions",
      "ec2:DescribeAvailabilityZones",
      "ec2:StartInstances",
      "ec2:StopInstances",
      "ec2:TerminateInstances",
      "ec2:CreateTags",
    ]

    resources = ["*"] 
  }
}

# S3 POLICY
resource "aws_iam_role_policy_attachment" "s3_policy_attachment" {
  role       = aws_iam_role.assume_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

resource "aws_iam_policy" "s3_policy" {
  name        = "my-s3-policy"
  policy      = data.aws_iam_policy_document.s3_policy.json
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject"
    ]
    resources = ["*"] 
  }
}

# CODE COMMIT POLICY
resource "aws_iam_role_policy_attachment" "code_commit_policy_attachment" {
  role       = aws_iam_role.assume_role.name
  policy_arn = aws_iam_policy.code_commit_policy.arn
}

resource "aws_iam_policy" "code_commit_policy" {
  name        = "my-code-commit-policy"
  policy      = data.aws_iam_policy_document.code_commit_policy.json
}

data "aws_iam_policy_document" "code_commit_policy" {
  statement {
    effect = "Allow"
    actions = [
      "codecommit:GetBranch",
      "codecommit:GetCommit",
      "codecommit:UploadArchive",
      "codecommit:GetUploadArchiveStatus",
      "codecommit:CancelUploadArchive"
    ]

    resources = ["*"] 
  }
}


# CODE BUILD POLICY
resource "aws_iam_role_policy_attachment" "code_build_policy_attachment" {
  role       = aws_iam_role.assume_role.name
  policy_arn = aws_iam_policy.code_build_policy.arn
}

resource "aws_iam_policy" "code_build_policy" {
  name        = "my-code-build-policy"
  policy      = data.aws_iam_policy_document.code_build_policy.json
}

data "aws_iam_policy_document" "code_build_policy" {
  statement {
    effect = "Allow"
    actions = [
      "codebuild:StartBuild",
      "codebuild:BatchGetBuilds",
    ]

    resources = ["*"] 
  }
}


# CODE DEPLOY POLICY
resource "aws_iam_role_policy_attachment" "code_deploy_policy_attachment" {
  role       = aws_iam_role.assume_role.name
  policy_arn = aws_iam_policy.code_deploy_policy.arn
}

resource "aws_iam_policy" "code_deploy_policy" {
  name        = "my-code-deploy-policy"
  policy      = data.aws_iam_policy_document.code_deploy_policy.json
}

data "aws_iam_policy_document" "code_deploy_policy" {
  statement {
    effect = "Allow"
    actions = [
      "codedeploy:RegisterApplicationRevision",
      "codedeploy:GetDeployment",
      "codedeploy:GetApplication",
      "codedeploy:CreateDeployment",
      "codedeploy:GetDeploymentConfig",
      "codedeploy:GetApplicationRevision",
    ]

    resources = ["*"] 
  }
}


# CODE PIPELINE POLICY
resource "aws_iam_role_policy_attachment" "code_pipeline_policy_attachment" {
  role       = aws_iam_role.assume_role.name
  policy_arn = aws_iam_policy.code_pipeline_policy.arn
}

resource "aws_iam_policy" "code_pipeline_policy" {
  name        = "my-code-pipeline-policy"
  policy      = data.aws_iam_policy_document.code_pipeline_policy.json
}

data "aws_iam_policy_document" "code_pipeline_policy" {
  statement {
    effect = "Allow"
    actions = [
      "codepipeline:StartPipelineExecution",
    ]

    resources = ["*"] 
  }
}

# LOG POLICY
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
      "logs:PutLogEvents"
    ]

    resources = ["*"] 
  }
}
