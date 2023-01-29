module "code_build_iam" {
  source      = "../../modules/code-build-iam"
  common_tags = var.common_tags

  aws_region    = var.aws.region
  subnet_list   = module.network.private_subnet_ids
  eks_role_name = module.eks_iam.eks_role_arn
}


module "code_build" {
  source      = "../../modules/code-build"
  common_tags = var.common_tags
  aws_region  = var.aws.region

  vpc_id                   = module.network.vpc_id
  subnet_list              = module.network.private_subnet_ids
  codebuild_security_group = module.network.codebuild_security_group_id

  service_role_arn                          = module.code_build_iam.code_build_iam_role_arn
  environment_variable_parameter_store_keys = module.parameter_store_code_build.parameters_map

  codebuild_configuration = {
    adhoc = {
      source_version  = "v3.0.10"
      repository_url  = "https://github.com/Izy-AS/3.0-adhoc.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    adhoc_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }

    booking = {
      source_version = "v3.0.11"
      repository_url = "https://github.com/Izy-AS/3.0-booking.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    booking_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }

    billing = {
      source_version = null
      repository_url = null
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    billing_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-billing.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    
    canteen = {
      source_version  = "v3.0.12"
      repository_url  = "https://github.com/Izy-AS/3.0-canteen.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    canteen_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }

    conferencemeal = {
      source_version  = "v3.0.12"
      repository_url  = "https://github.com/Izy-AS/3.0-conference-meal"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    conferencemeal_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }

    datamanagement = {
      source_version  = "v3.0.5"
      repository_url  = "https://github.com/Izy-AS/3.0-data-management"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    datamanagement_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }

    entities = {
      source_version  = "v3.0.12"
      repository_url  = "https://github.com/Izy-AS/3.0-entities.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    entities_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }

    filehandler = {
      source_version  = "v3.0.7"
      repository_url  = "https://github.com/Izy-AS/3.0-filehandler.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    filehandler_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }

    insight = {
      source_version  = "v3.0.5"
      repository_url  = "https://github.com/Izy-AS/3.0-insight.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    insight_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }

    invoice = {
      source_version  = "v3.0.10"
      repository_url  = "https://github.com/Izy-AS/3.0-invoice.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    invoice_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }

    izyportal = {
      source_version  = "v0.5.13"
      repository_url  = "https://github.com/Izy-AS/3.0-izy-portal.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    izyportal_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }

    kiosk = {
      source_version  = "v3.0.17"
      repository_url  = "https://github.com/Izy-AS/3.0-kiosk.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    kiosk_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }

    meetingroomdisplay = {
      source_version  = "v3.0.3"
      repository_url  = "https://github.com/Izy-AS/3.0-meetingroomdisplay.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    meetingroomdisplay_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }

    microsoftintegration = {
      source_version  = "v3.0.6"
      repository_url  = "https://github.com/Izy-AS/3.0-microsoft-integration.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    microsoftintegration_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }

    news = {
      source_version  = "v3.0.8"
      repository_url  = "https://github.com/Izy-AS/3.0-news.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    news_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }

    notification = {
      source_version  = "v3.0.7"
      repository_url  = "https://github.com/Izy-AS/3.0-notification.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    notification_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }

    payment = {
      source_version  = "v3.0.10"
      repository_url  = "https://github.com/Izy-AS/3.0-payment.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    payment_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }

    publicapi = {
      source_version  = "v3.0.5"
      repository_url  = "https://github.com/Izy-AS/3.0-public-api"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    publicapi_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }

    reports = {
      source_version  = "v3.0.9"
      repository_url  = "https://github.com/Izy-AS/3.0-reports.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    reports_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }

    scheduler = {
      source_version  = "v3.0.6"
      repository_url  = "https://github.com/Izy-AS/3.0-scheduler.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    scheduler_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }

    tickets = {
      source_version  = "v3.0.6"
      repository_url  = "https://github.com/Izy-AS/3.0-tickets.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    tickets_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-devops.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }

    usermanagement = {
      source_version  = "v3.0.10"
      repository_url  = "https://github.com/Izy-AS/3.0-user-management.git"
      logs            = {
        cloudwatch_logs = {
          status      = "ENABLED"
          group_name  = null
          stream_name = null
        }
      }
    }
    usermanagement_deploy = {
      source_version  = "master"
      repository_url  = "https://github.com/Izy-AS/3.0-devops.git"
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
