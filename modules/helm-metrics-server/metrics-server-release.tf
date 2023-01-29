resource "helm_release" "metrics-server" {
  name       = var.release_name
  namespace  = var.namespace
  repository = var.repository
  chart      = var.chart_name
  version    = var.chart_version
  atomic     = var.isAtomic
}
