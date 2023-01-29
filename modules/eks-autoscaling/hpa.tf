resource "kubernetes_horizontal_pod_autoscaler_v2" "eks_hpa" {
  metadata {
    #name      = "${local.tag_environment}-${var.service_name}"
    name      = "${var.service_name}"
    namespace = "apps"
  }

  spec {
    min_replicas = var.replica_min_size
    max_replicas = var.replica_max_size

    scale_target_ref {
      api_version = "apps/v1"
      kind = "Deployment"
      name = "${var.service_name}"
      # name = "${local.tag_environment}-${var.service_name}"
    }

    metric {
      type = "Resource"
      resource {
          name = "cpu"
        target {
          type                = "Utilization"
          average_utilization = var.average_utilization
        }
      }
    }

    behavior {
      scale_down {
        select_policy    = "Min"
        policy {
          type           = "Pods"
          value          = 2
          period_seconds = 15
        }
      }
      scale_up {
        select_policy    = "Min"
        policy {
          type           = "Percent"
          value          = 100
          period_seconds = 15
        }
        policy {
          type           = "Pods"
          value          = 4
          period_seconds = 15
        }
      }
    }
  }
}