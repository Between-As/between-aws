resource "helm_release" "fluent_bit" {
  name       = var.release_name
  namespace  = var.namespace
  repository = var.repository
  chart      = var.chart_name
  version    = var.chart_version
  atomic     = var.isAtomic

  values = [
    templatefile("${path.module}/fluent-bit-values.yaml", {
    })
  ]
}