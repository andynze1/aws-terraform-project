resource "time_sleep" "wait_for_kubernetes" {
  create_duration = "60s"
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
  depends_on = [
    time_sleep.wait_for_kubernetes
  ]
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
  depends_on = [
    time_sleep.wait_for_kubernetes
  ]
}

resource "helm_release" "argo_cd" {
  name             = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.argo_cd_version
  namespace        = kubernetes_namespace.argocd.id
  create_namespace = false
  skip_crds        = true
  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }
  set {
    name  = "server.ingress.enabled"
    value = "false"
  }
  depends_on = [
    time_sleep.wait_for_kubernetes,
    kubernetes_namespace.monitoring
  ]
}

resource "helm_release" "prometheus" {
  name             = "prometheus"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = kubernetes_namespace.monitoring.id 
  create_namespace = false
  #  version          = "51.3.0"
  values = [
    file("values.yaml")
  ]
  timeout = 600
  set {
    name  = "podSecurityPolicy.enabled"
    value = true
  }
  set {
    name  = "server.persistentVolume.enabled"
    value = false
  }
  # set {
  #   name  = "server.service.type"
  #   value = "LoadBalancer"
  # }
  set {
    name = "server\\.resources"
    value = yamlencode({
      limits = {
        cpu    = "200m"
        memory = "50Mi"
      }
      requests = {
        cpu    = "100m"
        memory = "30Mi"
      }
    })
  }
  depends_on = [
    time_sleep.wait_for_kubernetes,
    kubernetes_namespace.monitoring
  ]
}