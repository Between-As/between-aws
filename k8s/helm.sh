helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm repo add eks https://aws.github.io/eks-charts

helm install metrics-server bitnami/metrics-server -n tools
helm install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard -n tools
helm install aws-load-balancer-controller eks/aws-load-balancer-controller --set clusterName=izy30-eks-staging -n kube-system
