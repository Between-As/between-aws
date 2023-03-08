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

    #izyportal = [
    #   "aws_ecr_repository_url", "micro_service_name", "aws_ecr_repository_mirror_url_nginx",  "aws_ecr_repository_mirror_url_node"
    #]

    #izyportal_deploy = [
    #   "aws_ecr_repository_url", "micro_service_name"
    #]

    usermanagement = [
       "aws_ecr_repository_url", "root_db_username", "root_db_password", "user_name", "password", "micro_service_name"
    ]

    usermanagement_deploy = [
      "aws_ecr_repository_url", "micro_service_name"
    ]
  }
}
