resource "helm_release" "grafana_loki" {
  name       = var.release_name
  namespace  = var.namespace
  repository = var.repository
  chart      = var.chart_name
  version    = var.chart_version
  atomic     = var.isAtomic

  values = [
    templatefile("${path.module}/grafana-loki-values.yaml", {
      iam_service_role   = var.iam_service_role
      cluster_name       = var.cluster_name
      namespace          = var.namespace
      aws_region         = var.aws_region
      environment        = local.tag_environment
      s3_bucket          = var.s3_bucket
      read_replicas      = var.read_replicas
      write_replicas     = var.write_replicas
      index_prefix       = local.index_prefix
      loki_log_retention = var.loki_log_retention
    })
  ]
}