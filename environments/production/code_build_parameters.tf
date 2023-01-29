module "parameter_store_code_build" {
  source      = "../../modules/parameter-store-secure"
  common_tags = var.common_tags

  prefix = "code-build"

  parameter_store_keys = {
    common = [
      "aws_region"
    ]
    
    common_deploy = [
      "aws_default_region", "aws_cluster_name"
    ]

    common_build = [
      "vault_url", "env", "flask_app", "aws_ecr_repository_mirror_url"
    ]

    adhoc = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    adhoc_deploy = [
         "aws_ecr_repository_url", "micro_service_name"
    ]

    billing = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    billing_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]

    booking = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    booking_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]

    canteen = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    canteen_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]

    conferencemeal = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    conferencemeal_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]
    datamanagement = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    datamanagement_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]

    entities = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    entities_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]

    filehandler = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    filehandler_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]

    insight = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    insight_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]

    invoice = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    invoice_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]    

    izyportal = [
       "aws_ecr_repository_url", "micro_service_name", "aws_ecr_repository_mirror_url_nginx",  "aws_ecr_repository_mirror_url_node"
    ]

    izyportal_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]    

    kiosk = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    kiosk_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]

    meetingroomdisplay = [
       "aws_ecr_repository_url", "micro_service_name"
    ]

    meetingroomdisplay_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]

    microsoftintegration = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    microsoftintegration_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]

    news = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    news_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]

    notification = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    notification_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]

    payment = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    payment_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]

    publicapi = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    publicapi_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]

    rentspace = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    rentspace_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]

    reports = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    reports_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]

    scheduler = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    scheduler_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]

    tickets = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    tickets_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]

    usermanagement = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    usermanagement_deploy = [
       "aws_ecr_repository_url", "micro_service_name"
    ]
  }
}
