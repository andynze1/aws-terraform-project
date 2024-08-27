resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
  depends_on = [
    time_sleep.wait_for_kubernetes
  ]
}

resource "helm_release" "grafana" {
  name             = "grafana"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "grafana"
  namespace        = var.namespace_monitoring # kubernetes_namespace.monitor_namespace.metadata[0].name
  # version          = "11.1.4" #var.grafana_version
  create_namespace = false
  
  values = [
    file("${path.module}/kubernetes-yaml-files/grafana.values.yaml"),
    # yamlencode(var.settings_grafana)
  ]

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "adminPassword"
    value = var.grafana_admin_password
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}