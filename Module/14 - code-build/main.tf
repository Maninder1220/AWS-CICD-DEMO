resource "aws_codebuild_project" "my_build" {
  name          = "my-build"       # Change Name
  service_role  = var.assume_role_arn
  build_timeout   = "5"           # 5 minutes

    # Artifacts is where the build output is stored
    artifacts {
        type = "S3"
        location = var.codebuld_project_bucket_arti_cach
        path = "artifacts/"
        name = "my-artifacts.zip"
    }

    # Cache is where the build cache is stored
    cache {
        type = "S3"
        location = var.codebuld_project_bucket_arti_cach
    }

    # Environment is the build environment
    environment {
        compute_type                = "BUILD_GENERAL1_SMALL"        # 3GB 2vCPU
        image                       = "aws/codebuild/standard:4.0"  # Can add Docker image here
        type                        = "LINUX_CONTAINER"      
    }

    # Source is where the source code is stored
    source {
    type            = "CODECOMMIT"
    location        = var.code_commit_repository_one
  }

    # Logs is where the build logs are stored
    logs_config {
        cloudwatch_logs {
            group_name  = "/aws/codebuild/my-build"
            stream_name = "my-build"
        }
    } 
}