/*resource "kubernetes_manifest" "eks_ingressclass" {
  manifest = {
    apiVersion = "networking.k8s.io/v1"
    kind       = "IngressClass"

    metadata = {
      name = "alb"
    }

    spec = {
      controller = "ingress.k8s.aws/alb"
      parameters = {
        apiGroup = "elbv2.k8s.aws"
        kind = "IngressClassParams"
        name = "alb"
        scope = "Cluster"
      }
    }
  }  
}
*/