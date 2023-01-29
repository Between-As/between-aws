/*data "aws_caller_identity" "current" {}

resource "kubernetes_manifest" "configmap_kube_system_aws_auth" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "mapRoles" = <<-EOT
      - rolearn: arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/izy30-eks-production-worker-role
        username: system:node:{{EC2PrivateDNSName}}
        groups:
          - system:bootstrappers
          - system:nodes
      - rolearn: arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/izy30-eks-production-operator-role
        username: eks-operator
        groups:
          - system:masters
      - rolearn: arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/izy30-eks-production-readonly-role
        username: eks-readonly

      EOT
    }
    "kind" = "ConfigMap"
    "metadata" = {
      "name" = "aws-auth"
      "namespace" = "kube-system"
    }
  }
}*/