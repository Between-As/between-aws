**Manual actions required on monitoring stack:**

1. We're using the panel which is not included by default in Grafana so it have to be installed manually.

a) Jump into `kube-prometheus-stack-grafana-...` pod and open the shell of the `grafana` container.

b) Run belows command:
```
grafana-cli plugins install grafana-polystat-panel
```
c) Restart Grafana.

'

2. CloudWatch is one of the data sources in Grafana. To be able to get the data from it Grafana's serviceaccount `kube-prometheus-stack-grafana` need this annotation:

a) sandbox
```
    eks.amazonaws.com/role-arn: arn:aws:iam::803978285220:role/izy30-eks-sandbox-tools-grafana-servicerole
```
b) staging
```
    eks.amazonaws.com/role-arn: arn:aws:iam::803978285220:role/izy30-eks-staging-tools-grafana-servicerole
```
c) production
```
    eks.amazonaws.com/role-arn: arn:aws:iam::169207823547:role/izy30-eks-production-tools-grafana-servicerole
```