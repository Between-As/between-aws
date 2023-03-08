module "code_pipeline_artifacts_bucket" {
  source                   = "../../modules/s3"
  common_tags              = var.common_tags
  bucket_name              = "codepipeline-${var.aws.region}-${data.aws_caller_identity.current.account_id}"
  s3_default_bucket_policy = false
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# WARNING: Please import code_start and manually accept via console.. AWS issue..
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

module "code_star_connection" {
  source = "../../modules/codestar"
  connection_name = "between-github"
}

# module "code_pipeline" {
#   source      = "../../modules/code-pipeline"
#   common_tags = var.common_tags

#   pipeline_configuration = {
#     entities = {
#       Source = {
#         Source = {
#           configuration = {
#             BranchName           = "master"
#             DetectChanges        = null
#             FullRepositoryId     = "Izy-AS/3.0-entities"
#             OutputArtifactFormat = "CODE_ZIP"
#           }
#         }
#       }
#     }
#   }

#   artifact_bucket         = module.code_pipeline_artifacts_bucket.s3_bucket_name
#   pipeline_role_arn       = "arn:aws:iam::162725507128:role/development"
#   codestar_connection_arn = module.code_star_connection.codestar_connection_arn
# }
