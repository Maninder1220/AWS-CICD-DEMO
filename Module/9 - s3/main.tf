
resource "aws_s3_bucket" "artifact_n_log_bucket" {
    bucket = "my-artifact-and-logs-bucket-for-code-pipeline" # Change to your desired bucket name
    /*
    lifecycle {
    prevent_destroy = true  # Prevent accidental destruction
  }
  */
}

resource "null_resource" "empty_bucket" {
  provisioner "local-exec" {
    command = "aws s3 rm s3://my-artifact-and-logs-bucket-for-code-pipeline --recursive"
  }
}

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