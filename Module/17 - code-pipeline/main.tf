resource "aws_codepipeline" "mahity_pipeline" {
  name     = var.pipeline_name
  role_arn = var.assume_role_arn

  artifact_store {
    type     = "S3"
    location = var.codebuld_project_bucket_arti_cach
  }

  # Source Stage
  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        RepositoryName = var.code_commit_repository_one
        BranchName     = "master"
      }
    }
  }

  # Build Stage
  stage {
    name = "Build"

    action {
      name            = "Build"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["source_output"]
      output_artifacts = ["build_output"] 
      configuration = {
        ProjectName = var.codebuild_name
      }
      version = "1"
    }
  }

  
  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["build_output"]
      configuration = {
        ApplicationName     = var.code_deploy_app_name
        DeploymentGroupName = var.deployment_group_name
      }
      version = "1"
    }
  }
}
