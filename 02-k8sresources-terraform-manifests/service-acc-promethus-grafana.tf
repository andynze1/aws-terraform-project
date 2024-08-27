# Create a Service Account for Prometheus
resource "kubernetes_service_account" "prometheus" {
  metadata {
    name      = "prometheus"
    namespace = "monitoring"
  }
  depends_on = [ kubernetes_namespace.monitoring ]
}

# Create a ClusterRole for Prometheus
resource "kubernetes_cluster_role" "prometheus" {
  metadata {
    name = "prometheus"
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "nodes", "services", "endpoints", "namespaces"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["extensions", "apps"]
    resources  = ["deployments", "replicasets", "daemonsets", "statefulsets"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps"]
    verbs      = ["get"]
  }
}

# Bind the ClusterRole to the Prometheus Service Account
resource "kubernetes_cluster_role_binding" "prometheus" {
  metadata {
    name = "prometheus"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.prometheus.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.prometheus.metadata[0].name
    namespace = kubernetes_service_account.prometheus.metadata[0].namespace
  }
}

# Create a Service Account for Grafana
resource "kubernetes_service_account" "grafana" {
  metadata {
    name      = "grafana"
    namespace = "monitoring"
  }
  depends_on = [ kubernetes_namespace.monitoring ]
}

# Create a ClusterRole for Grafana
resource "kubernetes_cluster_role" "grafana" {
  metadata {
    name = "grafana"
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps", "pods", "services"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["monitoring.coreos.com"]
    resources  = ["prometheuses", "servicemonitors", "alertmanagers"]
    verbs      = ["get", "list", "watch"]
  }
}

# Bind the ClusterRole to the Grafana Service Account
resource "kubernetes_cluster_role_binding" "grafana" {
  metadata {
    name = "grafana"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.grafana.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.grafana.metadata[0].name
    namespace = kubernetes_service_account.grafana.metadata[0].namespace
  }
}


