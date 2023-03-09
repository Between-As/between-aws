module "eks_iam" {
  source      = "../../modules/eks-iam"
  common_tags = var.common_tags

  cluster_name           = var.eks_cluster_name
  node_kms_key_arn       = module.eks_nodes_kms.arn
  autoscalling_role_name = module.eks_nodes_kms.autoscalling_role_name

  #allowed_account_id_root = [local.hostersi_account_id]

  operator_principals = var.eks_operator_principals
  readonly_principals = var.eks_readonly_principals

  depends_on = [module.eks_nodes_kms]
}

module "eks_nodes_kms" {
  source      = "../../modules/kms-key"
  common_tags = var.common_tags

  alias                       = "eks-nodes-volume-key"
  add_autoscaling_permissions = true
}

module "eks_cluster" {
  source      = "../../modules/eks-cluster"
  common_tags = var.common_tags

  cluster_version     = "1.24"
  cluster_name        = var.eks_cluster_name
  cluster_role_arn    = module.eks_iam.eks_role_arn
  cluster_subnet_ids  = module.network.private_subnet_ids
  security_group_ids  = [module.network.security_groups["eks-cluster"].id]
  public_access_cidrs = var.eks_public_access_cidrs

  depends_on = [module.eks_iam]
}

module "eks_nodegroup" {
  source      = "../../modules/eks-nodegroup"
  common_tags = var.common_tags

  cluster_name      = module.eks_cluster.cluster_name
  node_role_arn     = module.eks_iam.eks_worker_arn
  node_subnet_ids   = module.network.private_subnet_ids
  desired_capacity  = 2
  max_capacity      = 8
  instance_type     = "t3.medium"
  volume_encryption = true
  # temporary no encryption
  #node_kms_key_arn = module.eks_nodes_kms.arn
  node_kms_key_arn  = ""

  depends_on = [module.eks_iam, module.eks_cluster]
}

module "eks_namespace" {
  source = "../../modules/eks-namespace"

  for_each = {
    "tools" = {
      name        = "tools"
      labels      = {}
      annotations = {}
    }
    "vault" = {
      name        = "vault"
      labels      = {}
      annotations = {}
    }
    "sandbox" = {
      name        = "sandbox"
      labels      = {}
      annotations = {}
    }
    "staging" = {
      name        = "staging"
      labels      = {}
      annotations = {}
    }
  }

  name        = each.value["name"]
  labels      = each.value["labels"]
  annotations = each.value["annotations"]

  depends_on = [module.eks_iam, module.eks_cluster]
}

module "eks_iam_roles" {
  source = "../../modules/eks-iam-role"

  for_each = {
    "vault" = {
      serviceaccount = "vault"
      namespace      = "vault"
      aws_role_name  = "vault-servicerole"
    }
    "vault-agent-injector" = {
      serviceaccount = "vault-agent-injector"
      namespace      = "vault"
      aws_role_name  = "vault-agent-injector-servicerole"
    }
    "aws-load-balancer-controller" = {
      serviceaccount = "aws-load-balancer-controller"
      namespace      = "kube-system"
      aws_role_name  = "aws-load-balancer-controller"
    }
    "loki" = {
      serviceaccount = "loki"
      namespace      = "tools"
      aws_role_name  = "loki-servicerole"
    }
    "grafana" = {
      serviceaccount = "kube-prometheus-stack-grafana"
      namespace      = "tools"
      aws_role_name  = "grafana-servicerole"
    }
  }

  common_tags    = var.common_tags
  cluster_name   = module.eks_cluster.cluster_name
  oidc_eks_url   = module.eks_cluster.oidc_eks_url
  oidc_eks_arn   = module.eks_cluster.oidc_eks_arn
  serviceaccount = each.value["serviceaccount"]
  namespace      = each.value["namespace"]
  aws_role_name  = each.value["aws_role_name"]

  depends_on = [module.eks_iam, module.eks_cluster]
}

module "eks_load_balancer_controller" {
  source = "../../modules/eks-load-balancer-controller"

  common_tags      = var.common_tags
  cluster_name     = module.eks_cluster.cluster_name
  iam_service_role = module.eks_iam_roles["aws-load-balancer-controller"].name

  depends_on = [module.eks_iam, module.eks_cluster, module.eks_iam_roles["aws-load-balancer-controller"]]
}

module "helm_external_dns" {
  source = "../../modules/helm-external-dns"

  namespace     = "kube-system"
  chart_version = "1.11.0"
  release_name  = "external-dns"
  chart_name    = "external-dns"
  repository    = "https://kubernetes-sigs.github.io/external-dns"
  isAtomic      = true

  common_tags      = var.common_tags
  cluster_name     = module.eks_cluster.cluster_name
  iam_service_role = var.external_dns_utilities_role_arn

  depends_on = [module.eks_cluster]
}

module "helm_cluster_autoscaler" {
  source = "../../modules/helm-cluster-autoscaler"

  namespace     = "kube-system"
  chart_version = "9.21.0"
  release_name  = "autoscaler"
  chart_name    = "cluster-autoscaler"
  repository    = "https://kubernetes.github.io/autoscaler"
  isAtomic      = true

  common_tags      = var.common_tags
  cluster_name     = module.eks_cluster.cluster_name
  iam_service_role = module.eks_iam.eks_worker_arn
  aws_region       = var.aws.region

  depends_on = [module.eks_nodegroup, module.eks_iam, module.eks_cluster]
}

module "helm_vault" {
  source = "../../modules/helm-vault"

  namespace     = "vault"
  chart_version = "0.21.0"
  release_name  = "vault"
  chart_name    = "vault"
  repository    = "https://helm.releases.hashicorp.com"
  isAtomic      = true

  dynamodb_table_name                   = module.vault_backend.dynamodb_table_name
  kms_key                               = module.vault_backend.kms_key_arn
  iam_vault_service_role                = module.eks_iam_roles["vault"].arn
  iam_vault_agent_injector_service_role = module.eks_iam_roles["vault-agent-injector"].arn

  depends_on = [module.vault_backend, module.eks_namespace["vault"]]
}

module "helm_load_balancer_controller" {
  source = "../../modules/helm-load-balancer-controller"

  namespace     = "kube-system"
  chart_version = "1.4.4"
  release_name  = "aws-load-balancer-controller"
  chart_name    = "aws-load-balancer-controller"
  repository    = "https://aws.github.io/eks-charts"
  isAtomic      = true

  iam_service_role = module.eks_iam_roles["aws-load-balancer-controller"].arn
  cluster_name     = module.eks_cluster.cluster_name

  depends_on = [module.eks_load_balancer_controller, module.eks_iam_roles["aws-load-balancer-controller"]]
}



//module "grafana_agent_eventhandler" {
//  source = "../../modules/grafana-agent-eventhandler"
//
//  depends_on = [module.eks_cluster, module.helm_grafana_loki]
//}
