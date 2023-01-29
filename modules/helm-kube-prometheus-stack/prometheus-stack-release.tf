resource "helm_release" "prometheus_stack" {
  name       = var.release_name
  namespace  = var.namespace
  repository = var.repository
  chart      = var.chart_name
  version    = var.chart_version
  atomic     = var.isAtomic

  values = [
    templatefile("${path.module}/prometheus-stack-values.yaml", {
      iam_service_role           = var.iam_service_role
      admin_password             = var.admin_password
      grafana_certificate        = var.grafana_certificate
      grafana_group_name         = var.grafana_group_name
      grafana_subnets            = var.grafana_subnets
      grafana_domain             = var.grafana_domain
      prometheus_certificate     = var.prometheus_certificate
      prometheus_group_name      = var.prometheus_group_name
      prometheus_subnets         = var.prometheus_subnets
      prometheus_domain          = var.prometheus_domain
    })
  ]
}
