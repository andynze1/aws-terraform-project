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
  # version          = var.argo_cd_version
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

resource "time_sleep" "wait_for_kubernetes" {
  create_duration = "60s"
}