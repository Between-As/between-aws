resource "helm_release" "load-balancer-controller" {
  name       = var.release_name
  namespace  = var.namespace
  repository = var.repository
  chart      = var.chart_name
  version    = var.chart_version
  atomic     = var.isAtomic

  values = [
    templatefile("${path.module}/lbc-values.yaml", {
      iam_service_role = var.iam_service_role
      cluster_name     = var.cluster_name
    })
  ]

}