terraform {
  required_version = "~> 1.1"

  required_providers {
    aws = {
      version = "~>4.12.0"
      source  = "hashicorp/aws"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

provider "aws" {
  region              = var.aws.region
  profile             = var.aws.profile
  allowed_account_ids = [var.aws.allowed_account_id]
}

provider "aws" {
  alias               = "non-prod"
  region              = var.aws.region_non_prod
  profile             = var.aws.profile
  allowed_account_ids = [var.aws.allowed_account_id]
}

provider "random" {
}

terraform {
  backend "s3" {
    bucket  = "terraform-state-bucket-eu-north-1-581141568906-utilities"
    key     = "terraform.tfstate"
    region  = "eu-north-1"
    profile = "izy-as-utilities"

    dynamodb_table = "dynamodbLockTable-utilities"
  }
}

