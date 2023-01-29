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
  connection_name = "izy-github"
}

# module "code_pipeline" {
#   source      = "../../modules/code-pipeline"
#   common_tags = var.common_tags

#   pipeline_configuration = {
#     rentspace = {
#       Source = {
#         Source = {
#           configuration = {
#             BranchName           = "master"
#             DetectChanges        = false
#             FullRepositoryId     = "Izy-AS/3.0-rent_space"
#             OutputArtifactFormat = "CODE_ZIP"
#           }
#         }
#       }
#     }

#     insight = {
#       Source = {
#         Source = {
#           configuration = {
#             BranchName           = "master"
#             DetectChanges        = null
#             FullRepositoryId     = "Izy-AS/3.0-insight"
#             OutputArtifactFormat = "CODE_ZIP"
#           }
#         }
#       }
#     }

#     billing = {
#       Source = {
#         Source = {
#           configuration = {
#             BranchName           = "master"
#             DetectChanges        = null
#             FullRepositoryId     = "Izy-AS/3.0-billing"
#             OutputArtifactFormat = "CODE_ZIP"
#           }
#         }
#       }
#     }

#     conferencemeal = {
#       Source = {
#         Source = {
#           configuration = {
#             BranchName           = "master"
#             DetectChanges        = null
#             FullRepositoryId     = "Izy-AS/3.0-conference-meal"
#             OutputArtifactFormat = "CODE_ZIP"
#           }
#         }
#       }
#     }

#     filehandler = {
#       Source = {
#         Source = {
#           configuration = {
#             BranchName           = "master"
#             DetectChanges        = null
#             FullRepositoryId     = "Izy-AS/3.0_file_handler"
#             OutputArtifactFormat = "CODE_ZIP"
#           }
#         }
#       }
#     }

#     invoice = {
#       Source = {
#         Source = {
#           configuration = {
#             BranchName           = "master"
#             DetectChanges        = null
#             FullRepositoryId     = "Izy-AS/3.0-invoice"
#             OutputArtifactFormat = "CODE_ZIP"
#           }
#         }
#       }
#     }

#     publicapi = {
#       Source = {
#         Source = {
#           configuration = {
#             BranchName           = "master"
#             DetectChanges        = null
#             FullRepositoryId     = "Izy-AS/3.0-public-api"
#             OutputArtifactFormat = "CODE_ZIP"
#           }
#         }
#       }
#     }

#     tickets = {
#       Source = {
#         Source = {
#           configuration = {
#             BranchName           = "master"
#             DetectChanges        = null
#             FullRepositoryId     = "Izy-AS/3.0-tickets"
#             OutputArtifactFormat = "CODE_ZIP"
#           }
#         }
#       }
#     }

#     adhoc = {
#       Source = {
#         Source = {
#           configuration = {
#             BranchName           = "master"
#             DetectChanges        = false
#             FullRepositoryId     = "Izy-AS/3.0-adhoc"
#             OutputArtifactFormat = "CODE_ZIP"
#           }
#         }
#         source-deploy = {
#           others = {
#             output_artifacts = "source-deploy"
#             namespace        = null
#           }
#           configuration = {
#             BranchName           = "master"
#             DetectChanges        = false
#             FullRepositoryId     = "Izy-AS/3.0-devops"
#             OutputArtifactFormat = "CODE_ZIP"
#           }
#         }
#       }
#       Deploy = {
#         Deploy = {
#           configuration = {
#             ProjectName = "${local.tag_environment}-adhoc-deploy"
#           }
#         }
#       }
#     }

#     izyportal = {
#       Source = {
#         Source = {
#           configuration = {
#             BranchName           = "master"
#             DetectChanges        = null
#             FullRepositoryId     = "Izy-AS/3.0-izy-portal"
#             OutputArtifactFormat = "CODE_ZIP"
#           }
#         }
#       }
#     }

#     reports = {
#       Source = {
#         Source = {
#           configuration = {
#             BranchName           = "master"
#             DetectChanges        = null
#             FullRepositoryId     = "Izy-AS/3.0-reports"
#             OutputArtifactFormat = "CODE_ZIP"
#           }
#         }
#       }
#     }

#     canteen = {
#       Source = {
#         Source = {
#           configuration = {
#             BranchName           = "master"
#             DetectChanges        = null
#             FullRepositoryId     = "Izy-AS/3.0-canteen"
#             OutputArtifactFormat = "CODE_ZIP"
#           }
#         }
#       }
#     }

#     payment = {
#       Source = {
#         Source = {
#           configuration = {
#             BranchName           = "master"
#             DetectChanges        = null
#             FullRepositoryId     = "Izy-AS/3.0-payment"
#             OutputArtifactFormat = "CODE_ZIP"
#           }
#         }
#       }
#     }

#     notification = {
#       Source = {
#         Source = {
#           configuration = {
#             BranchName           = "master"
#             DetectChanges        = null
#             FullRepositoryId     = "Izy-AS/3.0-notification"
#             OutputArtifactFormat = "CODE_ZIP"
#           }
#         }
#       }
#     }

#     scheduler = {
#       Source = {
#         Source = {
#           configuration = {
#             BranchName           = "master"
#             DetectChanges        = null
#             FullRepositoryId     = "Izy-AS/3.0-scheduler"
#             OutputArtifactFormat = "CODE_ZIP"
#           }
#         }
#       }
#     }

#     kiosk = {
#       Source = {
#         Source = {
#           configuration = {
#             BranchName           = "master"
#             DetectChanges        = null
#             FullRepositoryId     = "Izy-AS/3.0-kiosk"
#             OutputArtifactFormat = "CODE_ZIP"
#           }
#         }
#       }
#     }

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

#     datamanagement = {
#       Source = {
#         Source = {
#           configuration = {
#             BranchName           = "master"
#             DetectChanges        = null
#             FullRepositoryId     = "https://github.com/Izy-AS/3.0-data-management"
#             OutputArtifactFormat = "CODE_ZIP"
#           }
#         }
#       }
#     }

#   }

#   artifact_bucket         = module.code_pipeline_artifacts_bucket.s3_bucket_name
#   pipeline_role_arn       = "arn:aws:iam::759976795385:role/staging"
#   codestar_connection_arn = module.code_star_connection.codestar_connection_arn
# }
