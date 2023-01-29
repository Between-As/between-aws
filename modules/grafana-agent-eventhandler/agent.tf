resource "kubernetes_manifest" "eventhandler_serviceaccount" {
  manifest = yamldecode(<<-EOF
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: grafana-agent-eventhandler
      namespace: tools
    EOF
  )
}

resource "kubernetes_manifest" "eventhandler_clusterrole" {
  manifest = yamldecode(<<-EOF
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRole
    metadata:
      name: grafana-agent-eventhandler
    rules:
    - apiGroups:
      - ""
      resources:
      - events
      verbs:
      - get
      - list
      - watch
    EOF
  )
}

resource "kubernetes_manifest" "eventhandler_clusterrolebinding" {
  manifest = yamldecode(<<-EOF
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRoleBinding
    metadata:
      name: grafana-agent-eventhandler
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: ClusterRole
      name: grafana-agent-eventhandler
    subjects:
    - kind: ServiceAccount
      name: grafana-agent-eventhandler
      namespace: tools
    EOF
  )
}

resource "kubernetes_manifest" "eventhandler_service" {
  manifest = yamldecode(<<-EOF
    apiVersion: v1
    kind: Service
    metadata:
      name: grafana-agent-eventhandler-svc
      namespace: tools
    spec:
      ports:
      - port: 12345
        name: http-metrics
      clusterIP: None
      selector:
        name: grafana-agent-eventhandler
    EOF
  )
}

resource "kubernetes_manifest" "eventhandler_configmap" {
  manifest = yamldecode(<<-EOF
    kind: ConfigMap
    metadata:
      name: grafana-agent-eventhandler
      namespace: tools
    apiVersion: v1
    data:
      agent.yaml: |
        server:
          log_level: info

        integrations:
          eventhandler:
            cache_path: "/etc/eventhandler/eventhandler.cache"

        logs:
          configs:
          - name: default
            clients:
            - url: http://loki-gateway/api/prom/push
            positions:
              filename: /tmp/positions0.yaml
    EOF
  )
}

resource "kubernetes_manifest" "eventhandler_statefulset" {
  manifest = yamldecode(<<-EOF
    apiVersion: apps/v1
    kind: StatefulSet
    metadata:
      name: grafana-agent-eventhandler
      namespace: tools
    spec:
      serviceName: "grafana-agent-eventhandler-svc"
      selector:
        matchLabels:
          name: grafana-agent-eventhandler
      replicas: 1
      template:
        metadata:
          labels:
            name: grafana-agent-eventhandler
        spec:
          terminationGracePeriodSeconds: 10
          containers:
          - name: agent
            image: grafana/agent:main
            imagePullPolicy: IfNotPresent
            args:
            - -config.file=/etc/agent/agent.yaml
            - -enable-features=integrations-next
            - -server.http.address=0.0.0.0:12345
            command:
            - /bin/agent
            env:
            - name: HOSTNAME
              valueFrom:
                fieldRef:
                  fieldPath: spec.nodeName
            ports:
            - containerPort: 12345
              name: http-metrics
            volumeMounts:
            - name: grafana-agent
              mountPath: /etc/agent
            - name: eventhandler-cache
              mountPath: /etc/eventhandler
          serviceAccount: grafana-agent-eventhandler
          volumes:
            - configMap:
                name: grafana-agent-eventhandler
              name: grafana-agent
      volumeClaimTemplates:
      - metadata:
          name: eventhandler-cache
        spec:
          accessModes: [ "ReadWriteOnce" ]
          resources:
            requests:
              storage: 2Gi
    EOF
  )
}
