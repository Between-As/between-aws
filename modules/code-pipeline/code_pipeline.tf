resource "aws_codepipeline" "codepipeline" {
  for_each = var.pipeline_configuration
  name     = "${local.tag_environment}-${each.key}"
  role_arn = can(each.value.Source.Source.role_arn) ? each.value.Source.Source.role_arn : var.pipeline_role_arn

  artifact_store {
    location = var.artifact_bucket
    type     = "S3"
  }

  stage {
    name = "Source"
    dynamic "action" {
      for_each = each.value.Source
      content {
        name             = action.key
        namespace        = can(action.value.others.namespace) ? action.value.others.namespace : "SourceVariables"
        category         = "Source"
        owner            = "AWS"
        provider         = "CodeStarSourceConnection"
        version          = "1"
        output_artifacts = can(action.value.others.output_artifacts) ? [action.value.others.output_artifacts] : ["SourceArtifact"]
        configuration    = merge(action.value.configuration, { ConnectionArn = var.codestar_connection_arn })
      }
    }

  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      namespace        = "BuildVariables"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      version          = "1"

      configuration = {
        ProjectName = "${local.tag_environment}-${each.key}"
      }
    }
  }

  dynamic "stage" {
    for_each = can(each.value.Deploy) ? each.value.Deploy : tomap({})
    content {
      name = stage.key
      dynamic "action" {
        for_each = each.value.Deploy
        content {
          name            = action.key
          version         = "1"
          category        = "Build"
          owner           = "AWS"
          provider        = "CodeBuild"
          configuration   = action.value.configuration
          input_artifacts = ["source-deploy"]
        }
      }
    }
  }
}

