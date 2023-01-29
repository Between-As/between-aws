resource "kubernetes_manifest" "eks_ingress" {
  manifest = {
    apiVersion = "networking.k8s.io/v1"
    kind       = "Ingress"

    metadata = {
      name      = var.name
      namespace = var.namespace
      annotations = {
        "alb.ingress.kubernetes.io/group.name"       = var.group_name
        "alb.ingress.kubernetes.io/target-type"      = var.lb_target_type
        "alb.ingress.kubernetes.io/scheme"           = var.is_internal == true ? "internal" : "internet-facing"
        "alb.ingress.kubernetes.io/subnets"          = join(",", var.subnets)
        "alb.ingress.kubernetes.io/security-groups"  = join(",", var.security_groups)
        "alb.ingress.kubernetes.io/listen-ports"     = var.ports
        "alb.ingress.kubernetes.io/healthcheck-path" = var.healthcheck_path
        "alb.ingress.kubernetes.io/success-codes"    = var.healthcheck_success_codes
        "external-dns.alpha.kubernetes.io/hostname"  = var.domain_name
      }
    }

    spec = {
      ingressClassName = "alb"
      rules = [{
        host = var.domain_name
        http = {
          paths = [{
            backend = {
              service = {
                name = var.service_name
                port = {
                  number = var.service_port
                }
              }
            },
            path     = var.path
            pathType = var.path_type
          }]
        }
      }]
    }
  }
}