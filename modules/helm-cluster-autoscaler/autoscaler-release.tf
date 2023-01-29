resource "helm_release" "cluster-autoscaler" {
  name       = var.release_name
  namespace  = var.namespace
  repository = var.repository
  chart      = var.chart_name
  version    = var.chart_version
  atomic     = var.isAtomic

  values = [
    templatefile("${path.module}/autoscaler-values.yaml", {
      iam_service_role = var.iam_service_role
      cluster_name     = var.cluster_name
      aws_region       = var.aws_region
    })
  ]
}
