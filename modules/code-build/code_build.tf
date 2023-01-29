resource "aws_codebuild_project" "main" {
  for_each = var.codebuild_configuration

  name         = "${local.tag_environment}-${each.key}"
  service_role = var.service_role_arn

  source_version = each.value.source_version

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    privileged_mode             = true
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    dynamic "environment_variable" {
      for_each = {
        for item in var.environment_variable_parameter_store_keys : 
          item.name => item if (split("/",item.name)[3] == "common" 
            || (split("/",item.name)[3] == each.key) 
            || (startswith(split("/",item.name)[3],"common_") 
              && endswith(split("/",item.name)[3], "_deploy") == endswith(each.key, "_deploy")))
        }
      content {
        name =  upper(split("/",environment_variable.key)[4])
        value = environment_variable.key
        type  = "PARAMETER_STORE"
      }
    }
  }

  vpc_config {
    vpc_id = var.vpc_id
    subnets = var.subnet_list

    security_group_ids = [var.codebuild_security_group]
  }

  source {
    type            = each.value.repository_url == null ? "NO_SOURCE" : "GITHUB"
    location        = each.value.repository_url
    git_clone_depth = 1

    buildspec = fileexists("${path.module}/buildspec_files/${each.key}.conf") ? templatefile("${path.module}/buildspec_files/${each.key}.conf",{APP_ENV = local.tag_environment}) : templatefile("${path.module}/buildspec_files/common_deploy.conf",{APP_ENV = local.tag_environment, REGION = var.aws_region})

    git_submodules_config {
      fetch_submodules = false
    }
  }

  dynamic "logs_config" {
    for_each = each.value.logs
    content {
      dynamic "cloudwatch_logs" {
        for_each = logs_config.key == "cloudwatch_logs" ? toset([1]) : toset([])

        content {
          group_name  = logs_config.value.group_name
          stream_name = logs_config.value.stream_name
          status      = logs_config.value.status
        }
      }

      dynamic "s3_logs" {
        for_each = logs_config.key == "cloudwatch_logs" ? toset([]) : toset([])

        content {
        }
      }
    }
  }
}

