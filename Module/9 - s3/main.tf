
resource "aws_s3_bucket" "artifact_n_log_bucket" {
    bucket = "my-artifact-and-logs-bucket-for-code-pipeline" # Change to your desired bucket name
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
      "s3:ListBucket"
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