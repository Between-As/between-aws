terraform {
  required_version = "~> 1.3"

  required_providers {
    aws = {
      version = "~>4.12.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region              = var.aws.region
  profile             = var.aws.profile
  allowed_account_ids = [var.aws.allowed_account_id]
}

terraform {
  backend "s3" {
    bucket  = "terraform-state-bucket-eu-west-1-759976795385-staging"
    key     = "terraform.tfstate"
    region  = "eu-west-1"
    profile = "izy30-dev"

    dynamodb_table = "dynamodbLockTable-staging"
  }
}

provider "kubernetes" {
  host                   = module.eks_cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_cluster.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--profile", var.aws.profile, "--cluster-name", module.eks_cluster.cluster_name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks_cluster.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks_cluster.cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--profile", var.aws.profile, "--cluster-name", module.eks_cluster.cluster_name]
      command     = "aws"
    }
  }
}