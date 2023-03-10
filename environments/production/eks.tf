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
  desired_capacity  = 1
  instance_type     = "t3.medium"
  volume_encryption = true
  node_kms_key_arn  = module.eks_nodes_kms.arn
  min_capacity      = var.eks_nodes_asg_min_capacity
  max_capacity      = var.eks_nodes_asg_max_capacity

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
    "apps" = {
      name        = "apps"
      labels      = {}
      annotations = {}
    }
  }

  name        = each.value["name"]
  labels      = each.value["labels"]
  annotations = each.value["annotations"]

  depends_on = [module.eks_iam, module.eks_cluster]
}

module "eks_manifests" {
  source = "../../modules/eks-manifests"

  depends_on = [module.eks_iam, module.eks_cluster]
}

module "eks_load_balancer_controller" {
  source = "../../modules/eks-load-balancer-controller"

  common_tags      = var.common_tags
  cluster_name     = module.eks_cluster.cluster_name
  iam_service_role = module.eks_iam_roles["aws-load-balancer-controller"].name

  depends_on = [module.eks_iam, module.eks_cluster, module.eks_iam_roles["aws-load-balancer-controller"]]
}

module "eks_ingress" {
  source = "../../modules/eks-ingress"

  for_each = {
    "vault.izy.no" = {
      domain_name               = "vault.izy.no"
      group_name                = "apps"
      service_name              = "vault"
      service_port              = 8200
      path                      = "/"
      path_type                 = "Prefix"
      name                      = "vault"
      namespace                 = "vault"
      ports                     = "[{\"HTTP\": 80}]"
      lb_target_type            = "ip"
      is_internal               = "true"
      healthcheck_path          = "/v1/sys/health"
      healthcheck_success_codes = "200"
      subnets                   = module.network.private_subnet_ids
      security_groups           = []
      #security_groups           = [module.network.codebuild_security_group_id, module.network.security_groups["eks-cluster"].id, module.network.vault_access_security_group_id]
    }
  }

  domain_name               = each.value["domain_name"]
  group_name                = each.value["group_name"]
  service_name              = each.value["service_name"]
  service_port              = each.value["service_port"]
  path                      = each.value["path"]
  path_type                 = each.value["path_type"]
  name                      = each.value["name"]
  namespace                 = each.value["namespace"]
  ports                     = each.value["ports"]
  lb_target_type            = each.value["lb_target_type"]
  is_internal               = each.value["is_internal"]
  healthcheck_path          = each.value["healthcheck_path"]
  healthcheck_success_codes = each.value["healthcheck_success_codes"]
  subnets                   = each.value["subnets"]
  security_groups           = each.value["security_groups"]
  common_tags               = var.common_tags
  cluster_name              = module.eks_cluster.cluster_name

  depends_on = [module.eks_iam, module.eks_cluster, module.eks_load_balancer_controller, module.eks_iam_roles["aws-load-balancer-controller"]]
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

module "helm_external_dns" {
  source = "../../modules/helm-external-dns"

  namespace     = "kube-system"
  chart_version = "1.11.0"
  release_name  = "external-dns"
  chart_name    = "external-dns"
  repository    = "https://kubernetes-sigs.github.io/external-dns"
  isAtomic      = true

  common_tags             = var.common_tags
  cluster_name            = module.eks_cluster.cluster_name
  iam_service_role        = var.external_dns_utilities_role_arn

  depends_on = [module.eks_cluster]
}

module "helm_metrics_server" {
  source = "../../modules/helm-metrics-server"

  namespace     = "tools"
  chart_version = "v3.8.2"
  release_name  = "metrics-server"
  chart_name    = "metrics-server"
  repository    = "https://kubernetes-sigs.github.io/metrics-server"
  isAtomic      = true

  cluster_name  = module.eks_cluster.cluster_name

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

module "eks_autoscaling" {
  source = "../../modules/eks-autoscaling"

  for_each = {
    "adhoc" = {
      service_name        = "adhoc"
      replica_min_size    = 2
      replica_max_size    = 20
      average_utilization = 70
    }
    "booking" = {
      service_name        = "booking"
      replica_min_size    = 2
      replica_max_size    = 20
      average_utilization = 70
    }
    "canteen" = {
      service_name        = "canteen"
      replica_min_size    = 2
      replica_max_size    = 20
      average_utilization = 70
    }
    "conferencemeal" = {
      service_name        = "conferencemeal"
      replica_min_size    = 2
      replica_max_size    = 20
      average_utilization = 70
    }
    "datamanagement" = {
      service_name        = "datamanagement"
      replica_min_size    = 2
      replica_max_size    = 20
      average_utilization = 70
    }
    "entities" = {
      service_name        = "entities"
      replica_min_size    = 2
      replica_max_size    = 20
      average_utilization = 70
    }
    "filehandler" = {
      service_name        = "filehandler"
      replica_min_size    = 2
      replica_max_size    = 20
      average_utilization = 70
    }
    "insight" = {
      service_name        = "insight"
      replica_min_size    = 2
      replica_max_size    = 20
      average_utilization = 70
    }
    "invoice" = {
      service_name        = "invoice"
      replica_min_size    = 2
      replica_max_size    = 20
      average_utilization = 70
    }
    "izyportal" = {
      service_name        = "izyportal"
      replica_min_size    = 2
      replica_max_size    = 20
      average_utilization = 70
    }
    "kiosk" = {
      service_name        = "kiosk"
      replica_min_size    = 2
      replica_max_size    = 20
      average_utilization = 70
    }
    "microsoftintegration" = {
      service_name        = "microsoftintegration"
      replica_min_size    = 2
      replica_max_size    = 20
      average_utilization = 70
    }
    "news" = {
      service_name        = "news"
      replica_min_size    = 2
      replica_max_size    = 20
      average_utilization = 70
    }
    "notification" = {
      service_name        = "notification"
      replica_min_size    = 2
      replica_max_size    = 20
      average_utilization = 70
    }
    "payment" = {
      service_name        = "payment"
      replica_min_size    = 2
      replica_max_size    = 20
      average_utilization = 70
    }
    "publicapi" = {
      service_name        = "publicapi"
      replica_min_size    = 2
      replica_max_size    = 20
      average_utilization = 70
    }
    "reports" = {
      service_name        = "reports"
      replica_min_size    = 2
      replica_max_size    = 20
      average_utilization = 70
    }
    "scheduler" = {
      service_name        = "scheduler"
      replica_min_size    = 2
      replica_max_size    = 20
      average_utilization = 70
    }
    "tickets" = {
      service_name        = "tickets"
      replica_min_size    = 2
      replica_max_size    = 20
      average_utilization = 70
    }
    "usermanagement" = {
      service_name        = "usermanagement"
      replica_min_size    = 2
      replica_max_size    = 20
      average_utilization = 70
    }
  }

  service_name        = each.value["service_name"]
  replica_min_size    = each.value["replica_min_size"]
  replica_max_size    = each.value["replica_max_size"]
  average_utilization = each.value["average_utilization"]
  common_tags         = var.common_tags

  depends_on = [module.helm_metrics_server]
}

module "helm_fluent_bit" {
  source = "../../modules/helm-fluent-bit"

  namespace     = "tools"
  chart_version = "0.21.7"
  release_name  = "fluent"
  chart_name    = "fluent-bit"
  repository    = "https://fluent.github.io/helm-charts"
  isAtomic      = true

  depends_on = [module.eks_cluster, module.helm_grafana_loki]
}

module "helm_grafana_loki" {
  source = "../../modules/helm-grafana-loki"

  namespace     = "tools"
  chart_version = "3.8.1"
  release_name  = "grafana"
  chart_name    = "loki"
  repository    = "https://grafana.github.io/helm-charts"
  isAtomic      = true

  common_tags        = var.common_tags
  cluster_name       = module.eks_cluster.cluster_name
  iam_service_role   = module.eks_iam_roles["loki"].arn
  aws_region         = var.aws.region
  s3_bucket          = module.s3_loki_storage.s3_bucket_name
  read_replicas      = 1
  write_replicas     = 1
  loki_log_retention = var.loki_log_retention

  depends_on = [module.eks_cluster, module.eks_iam_roles["loki"], module.loki_backend]
}

module "helm_kube_prometheus_stack" {
  source = "../../modules/helm-kube-prometheus-stack"

  namespace     = "tools"
  chart_version = "41.8.0"
  release_name  = "kube-prometheus-stack"
  chart_name    = "kube-prometheus-stack"
  repository    = "https://prometheus-community.github.io/helm-charts"
  isAtomic      = true

  iam_service_role           = module.eks_iam_roles["grafana"].arn
  admin_password             = var.admin_password
  grafana_certificate        = var.grafana_certificate
  grafana_group_name         = var.grafana_group_name
  grafana_subnets            = var.grafana_subnets
  grafana_domain             = var.grafana_domain
  prometheus_certificate     = var.prometheus_certificate
  prometheus_group_name      = var.prometheus_group_name
  prometheus_subnets         = var.prometheus_subnets
  prometheus_domain          = var.prometheus_domain

  depends_on = [module.eks_cluster, module.eks_iam_roles["grafana"]]
}

module "grafana_agent_eventhandler" {
  source = "../../modules/grafana-agent-eventhandler"

  depends_on = [module.eks_cluster, module.helm_grafana_loki]
}
