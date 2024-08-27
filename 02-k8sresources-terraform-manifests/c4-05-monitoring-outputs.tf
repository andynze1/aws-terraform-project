# # EBS CSI Helm Release Outputs
# output "ebs_csi_helm_metadata" {
#   description = "Metadata Block outlining status of the deployed release."
#   value       = helm_release.ebs_csi_driver.metadata
# }


output "prometheus_helm_metadata" {
  description = "Metadata Block outlining status of the deployed release."
  value       = helm_release.prometheus.status
}

output "grafana_helm_metadata" {
  description = "Metadata Block outlining status of the deployed release."
  value       = helm_release.grafana.metadata
}

output "argo_cd_helm_metadata" {
  description = "Metadata Block outlining status of the deployed release."
  value       = helm_release.argo_cd.metadata
}


# output "logstash_helm_metadata" {
#   description = "Metadata Block outlining status of the deployed release."
#   value       = helm_release.logstash.metadata
# }


# output "filebeat_helm_metadata" {
#   description = "Metadata Block outlining status of the deployed release."
#   value       = helm_release.filebeat.metadata
# }

# output "raw_kibana_status" {
#   description = "Metadata Block outlining status of the deployed release."
#   value       = helm_release.kibana.metadata
# }


# output "fluentd_helm_metadata" {
#   description = "Metadata Block outlining status of the deployed release."
#   value       = helm_release.fluentd.metadata
# }

# output "fluentd_url" {
#   value = "http://${helm_release.fluentd.name}-master.${helm_release.fluentd.namespace}.svc.cluster.local:9200"
# }