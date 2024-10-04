# My ACTUAL ARTIFACTS BUCKET
resource "aws_s3_bucket" "artifact_n_log_bucket" {
    bucket = "my-artifact-and-logs-bucket-for-code-pipeline" # Change to your desired bucket name
    # region = "ap-south-1"
    
    lifecycle {
    prevent_destroy = false  # Prevent accidental destruction
  }
}

# This ensures that all contents of the bucket are removed before the bucket is deleted
resource "null_resource" "empty_bucket" {
  provisioner "local-exec" {
    command = "aws s3 rm s3://my-artifact-and-logs-bucket-for-code-pipeline --recursive"
  }
  depends_on = [ aws_s3_bucket.artifact_n_log_bucket ]
}

# Runs after the bucket is emptied
resource "null_resource" "delete_bucket" {
  depends_on = [null_resource.empty_bucket, aws_s3_bucket.artifact_n_log_bucket]
  
  provisioner "local-exec" {
    command = "aws s3api delete-bucket --bucket my-artifact-and-logs-bucket-for-code-pipeline"
  }
  
}


# Define the bucket policy to allow CodePipeline to access the bucket
resource "aws_s3_bucket_policy" "cicd_s3_policy" {
  bucket = aws_s3_bucket.artifact_n_log_bucket.id
  policy = data.aws_iam_policy_document.cicd_s3_policy.json
}

data "aws_iam_policy_document" "cicd_s3_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:DeleteObject"
    ]

    resources = [
      aws_s3_bucket.artifact_n_log_bucket.arn,
      "${aws_s3_bucket.artifact_n_log_bucket.arn}/*"
    ]

    principals {
      type        = "Service"
      identifiers = [
        "codepipeline.amazonaws.com",
        "codebuild.amazonaws.com",
        "codedeploy.amazonaws.com"
        ]
    }
  }
  depends_on = [ aws_s3_bucket.artifact_n_log_bucket ]
}