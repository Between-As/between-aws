
module "code_build" {
  source      = "../../modules/code-build"
  common_tags = var.common_tags
  aws_region  = var.aws.region

  vpc_id                   = module.network.vpc_id
  subnet_list              = module.network.private_subnet_ids
  codebuild_security_group = module.network.codebuild_security_group_id

  service_role_arn = "arn:aws:iam::162725507128:role/codebuild-development-1"
  environment_variable_parameter_store_keys = module.parameter_store_code_build.parameters_map

  codebuild_configuration = {
    usermanagement = {
      source_version  = "v1.0.0"
      repository_url  = "https://github.com/Between-As/between-usermanagement.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    usermanagement_deploy = {
      source_version  = "main"
      repository_url  = "https://github.com/Between-As/between-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    crm = {
      source_version  = "v1.0.0"
      repository_url  = "https://github.com/Between-As/between-crm-backend.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    crm_deploy = {
      source_version  = "main"
      repository_url  = "https://github.com/Between-As/between-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
  }
}
