resource "helm_release" "vault" {
  name       = var.release_name
  namespace  = var.namespace
  repository = var.repository
  chart      = var.chart_name
  version    = var.chart_version
  atomic     = var.isAtomic

  values = [
    templatefile("${path.module}/vault-values.yaml", {
      dynamodb_table_name                   = var.dynamodb_table_name
      kms_key                               = var.kms_key
      iam_vault_service_role                = var.iam_vault_service_role
      iam_vault_agent_injector_service_role = var.iam_vault_agent_injector_service_role
    })
  ]

}