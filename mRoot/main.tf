# # # # NETWORKING STACK # # # #

# VPC
module "vpc" {
  source          = "../Module/1 - vpc"
  vpc_cider_block = var.vpc_cider_block
}

# Availability Zones
module "az" {
  source          = "../Module/2 - availability-zone"
}

# Subnets
module "subnets" {
  source              = "../Module/3 - subnets"
  selected_azs        = module.az.selected_azs
  vpc_id              = module.vpc.vpc_id
  public_subnet_cidr  = var.public_subnet_cidr 
  private_subnet_cidr = var.private_subnet_cidr
}

# Security Groups
module "security-group" {
  source = "../Module/4 - security-group"
  vpc_id = module.vpc.vpc_id
}

# NAT Gateway
module "nat-gateway" {
  source = "../Module/5 - nat-gateway"
  public_subnet_id = module.subnets.public_subnet_id
}

# Internet Gateway
module "ig" {
  source = "../Module/6 - internet-gateway"
  vpc_id = module.vpc.vpc_id
}

# ROUTING
module "routing" {
  source = "../Module/7 - routing"
  vpc_id = module.vpc.vpc_id
  nat_gateway_id = module.nat-gateway.nat_gateway_id
  ig_id = module.ig.ig_id
  public_destination_cider = var.public_destination_cider
  private_destination_cider = var.private_destination_cider
  public_subnet_id = module.subnets.public_subnet_id
  private_subnet_id = module.subnets.private_subnet_id
}

# NACL
module "nacl" {
  source = "../Module/8 - nacl"
  vpc_id = module.vpc.vpc_id
  private_subnet_id = module.subnets.private_subnet_id
  public_subnet_id = module.subnets.public_subnet_id
}

# # # # SERVICES OF CICD STACK # # # #

# S3
module "s3" {
  source = "../Module/9 - s3"
}

# ROLE
module "assume-role" {
  source = "../Module/10 - role"
  cicd_role_name = var.cicd_role_name
  
}

# EC2 Key Pair
module "ec2-key-pair" {
  source = "../Module/11 - ec2-key-pair"
}

# EC2 Instance
module "ec2" {
  source = "../Module/12 - ec2"
  sg_id = module.security-group.sg_id
  public_subnet_id = module.subnets.public_subnet_id
  public_key = module.ec2-key-pair.public_key
}

# # # # CICD STACK # # # #

# CODE COMMIT
module "code-commit" {
  source = "../Module/13 - code-commit"
  repo-one-name = var.repo-one-name
}

# CODE BUILD
module "code-build" {
  source = "../Module/14 - code-build"
  assume_role_arn = module.assume-role.assume_role_arn
  code_commit_repository_one = module.code-commit.code_commit_repository_one
  codebuld_project_bucket_arti_cach = module.s3.codebuld_project_bucket_arti_cach
}

# CODE DEPLOY APP
module "code-deploy-app" {
  source = "../Module/15 - code-deploy-app"
  code_deploy_app_name = var.code_deploy_app_name
  ec2_id = module.ec2.ec2_id
}

# CODE DEPLOY GROUP
module "code-deploy-group" {
  source = "../Module/16 - code-deploy-group"
  assume_role_arn = module.assume-role.assume_role_arn
  code_deploy_app_name = module.code-deploy-app.code_deploy_app_name
  deployment_group_one = var.deployment_group_one
  cd_app_id = module.code-deploy-app.cd_app_id
}


# CODE PIPELINE
module "code-pipeline" {
  source = "../Module/17 - code-pipeline"
  assume_role_arn = module.assume-role.assume_role_arn
  code_commit_repository_one = module.code-commit.code_commit_repository_one
  codebuld_project_bucket_arti_cach = module.s3.codebuld_project_bucket_arti_cach
  pipeline_name = var.pipeline_name
  codebuild_name = module.code-build.codebuild_name
  code_deploy_app_name = module.code-deploy-app.code_deploy_app_name
  deployment_group_name = module.code-deploy-group.deployment_group_name
}

# Cloud Watch | Log Group
module "cloud-watch-log-group" {
  source = "../Module/18 - cloud-watch-log-group"
}

# Cloud Watch | Event Rule
module "event-rule" {
  source = "../Module/19 - cloud-watch-event-rule"
  cc_trigger_codepipeline = var.cc_trigger_codepipeline
}

# Cloud Watch | Event Target
module "event-target" {
  source = "../Module/20 - cloudwatch-event-target"
  code_pipeline_arn = module.code-pipeline.code_pipeline_arn
  event_rule_name = module.event-rule.event_rule_name
  assume_role_arn = module.assume-role.assume_role_arn
}

