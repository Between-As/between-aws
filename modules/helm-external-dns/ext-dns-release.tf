resource "helm_release" "external-dns" {
  name       = var.release_name
  namespace  = var.namespace
  repository = var.repository
  chart      = var.chart_name
  version    = var.chart_version
  atomic     = var.isAtomic

  values = [
    templatefile("${path.module}/ext-dns-values.yaml", {
      iam_service_role = var.iam_service_role
    })
  ]
}
