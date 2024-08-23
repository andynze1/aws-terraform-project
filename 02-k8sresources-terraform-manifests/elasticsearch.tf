
# # resource "kubernetes_storage_class" "elasticsearch_sc" {
#   metadata {
#     name = "elasticsearch-sc"
#   }
#   storage_provisioner = "ebs.csi.aws.com"
#   parameters = {
#     type  = "gp2"
#     fsType = "ext4"
#   }
#   reclaim_policy     = "Delete"
#   volume_binding_mode = "WaitForFirstConsumer"
#   depends_on = [helm_release.ebs_csi_driver]
# }


# # # Elasticsearch
# resource "helm_release" "elasticsearch" {
#   name       = "elasticsearch"
#   repository = "https://helm.elastic.co"
#   chart      = "elasticsearch"
#   namespace  = "logging"

#   create_namespace = false
#   timeout          = 1200

#   values = [
#     <<EOF
# clusterName: "elasticsearch"
# nodeGroup: "master"

# persistence:
#   enabled: true
#   size: 10Gi  # Size of the PersistentVolumeClaim
#   storageClass: "elasticsearch-sc"

# replicas: 1

# esConfig:
#   elasticsearch.yml: |
#     xpack.ml.enabled: false
#     cluster.routing.allocation.disk.threshold_enabled: true
#     cluster.routing.allocation.disk.watermark.low: "85%"
#     cluster.routing.allocation.disk.watermark.high: "90%"
#     cluster.routing.allocation.disk.watermark.flood_stage: "95%"
#     node.store.allow_mmap: false

# resources:
#   requests:
#     cpu: "1"
#     memory: "256Mi"
#   limits:
#     cpu: "2"
#     memory: "1Gi"

# service:
#   type: ClusterIP
# EOF
#   ]

#   depends_on = [kubernetes_storage_class.elasticsearch_sc]
# }



# resource "helm_release" "fluentd" {
#   name       = "fluentd"
#   repository = "https://fluent.github.io/helm-charts"
#   chart      = "fluentd"
#   namespace  = "logging" # or "kube-system" if you prefer

#   create_namespace = false

#   values = [
#     <<EOF
# daemonset:
#   enabled: true

# env:
#   FLUENT_ELASTICSEARCH_HOST: "elasticsearch.logging.svc.cluster.local"
#   FLUENT_ELASTICSEARCH_PORT: "9200"

# elasticsearch:
#   host: "elasticsearch.logging.svc.cluster.local"
#   port: 9200
#   scheme: http

# resources:
#   limits:
#     memory: 500Mi
#     cpu: 200m
#   requests:
#     memory: 200Mi
#     cpu: 100m

# serviceAccount:
#   create: false
#   name: "csi-controller-sa" 

# tolerations:
#   - key: "node-role.kubernetes.io/master"
#     effect: "NoSchedule"
# EOF
#   ]
# }


# # Kibana
# resource "helm_release" "kibana" {
#   name             = "kibana"
#   repository       = "https://helm.elastic.co"
#   chart            = "kibana"
#   namespace        = "logging"
#   create_namespace = false

#   depends_on = [
#     # helm_release.elasticsearch,
#     helm_release.fluentd
#   ]

#   values = [
#     <<EOF
# elasticsearchHosts: "http://elasticsearch-master:9200"
# resources:
#   requests:
#     cpu: "100m"
#     memory: "256Mi"
#   limits:
#     cpu: "500m"
#     memory: "512Mi"
# service:
#   type: LoadBalancer
#   port: 5601
# EOF
#   ]
# }

# # Logstash
# resource "helm_release" "logstash" {
#   name             = "logstash"
#   repository       = "https://helm.elastic.co"
#   chart            = "logstash"
#   namespace        = "logging"
#   create_namespace = false

#   depends_on = [
#     # helm_release.elasticsearch
#     helm_release.fluentd
#   ]

#   values = [
#     <<EOF
# logstashConfig:
#   logstash.yml: |
#     xpack.monitoring.enabled: true
#     xpack.monitoring.elasticsearch.hosts: [ "http://elasticsearch-master:9200" ]
# resources:
#   requests:
#     cpu: "100m"
#     memory: "256Mi"
#   limits:
#     cpu: "500m"
#     memory: "512Mi"
# service:
#   type: ClusterIP
# EOF
#   ]
# }

# # Filebeat
# resource "helm_release" "filebeat" {
#   name             = "filebeat"
#   repository       = "https://helm.elastic.co"
#   chart            = "filebeat"
#   namespace        = "logging"
#   create_namespace = false

#   depends_on = [
#     # helm_release.elasticsearch,
#     helm_release.logstash,
#   ]

#   values = [
#     <<EOF
# filebeatConfig:
#   filebeat.yml: |
#     filebeat.inputs:
#     - type: log
#       paths:
#         - /var/log/*.log
#     output.logstash:
#       hosts: ["logstash.logging.svc.cluster.local:5044"]
# resources:
#   requests:
#     cpu: "100m"
#     memory: "256Mi"
#   limits:
#     cpu: "500m"
#     memory: "512Mi"
# EOF
#   ]
# }

# ################################################################
# resource "kubernetes_service_v1" "kibana_lb_service" {
#   metadata {
#     name      = "kibana-lb-service"
#     namespace = "logging"
#   }

#   spec {
#     selector = {
#       app = kubernetes_deployment_v1.myapp1.spec.0.selector.0.match_labels.app
#     }

#     port {
#       name        = "http"
#       port        = 5601
#       target_port = 5601
#     }

#     type = "LoadBalancer"
#   }
#   depends_on = [kubernetes_deployment_v1.myapp1]
# }

# resource "kubernetes_deployment_v1" "kibana" {
#   metadata {
#     name      = "kibana"
#     namespace = "logging"
#   }

#   spec {
#     replicas = 1

#     selector {
#       match_labels = {
#         app = "kibana"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "kibana"
#         }
#       }

#       spec {
#         container {
#           name  = "kibana"
#           image = "kibana:8.15.0" # Replace with your version

#           port {
#             container_port = 5601
#           }
#         }
#       }
#     }
#   }
# }

