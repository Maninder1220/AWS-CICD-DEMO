resource "aws_codepipeline" "mahity_pipeline" {
  name     = var.pipeline_name
  role_arn = var.assume_role_arn

  artifact_store {
    type     = "S3"
    location = var.codebuld_project_bucket_arti_cach
  }

  # Source Stage
  stage {
    name = "CodeCommit-Source"

    action {
      name             = "CC_Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"      # "GitHub" or "Bitbucket"
      version          = "1"
      output_artifacts = ["cc_source_output"]
      configuration = {
        RepositoryName = var.code_commit_repository_one
        BranchName     = "master"
      }
    }
  }

  # Build Stage
  stage {
    name = "CodeBuild-Build"

    action {
      name            = "CB_Build"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["cc_source_output"]
      output_artifacts = ["cb_build_output"] 
      configuration = {
        ProjectName = var.codebuild_name
      }
      version = "1"
    }
  }

  # Deploy Stage
  stage {
    name = "CodeDeploy-Deploy"

    action {
      name            = "CD_Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["cb_build_output"]
      configuration = {
        ApplicationName     = var.code_deploy_app_name
        DeploymentGroupName = var.deployment_group_name
      }

      version = "1"
    }
  }
}
