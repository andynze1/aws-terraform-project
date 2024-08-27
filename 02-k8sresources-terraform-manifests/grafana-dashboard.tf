resource "kubernetes_config_map_v1" "volumes-dashboard" {
  metadata {
    name      = "volumes-dashboard-alerting"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "dashboard.json" = "${file("${path.module}/grafana-configmaps/volume-alerting.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}

resource "kubernetes_config_map_v1" "node" {
  metadata {
    name      = "node"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "node.json" = "${file("${path.module}/grafana-configmaps/node.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}

resource "kubernetes_config_map_v1" "coredns" {
  metadata {
    name      = "coredns"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "coredns.json" = "${file("${path.module}/grafana-configmaps/coredns.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
resource "kubernetes_config_map_v1" "api" {
  metadata {
    name      = "api"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "api.json" = "${file("${path.module}/grafana-configmaps/api.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
resource "kubernetes_config_map_v1" "kubelet" {
  metadata {
    name      = "kubelet"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "kubelet.json" = "${file("${path.module}/grafana-configmaps/kubelet.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
resource "kubernetes_config_map_v1" "proxy" {
  metadata {
    name      = "proxy"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "proxy.json" = "${file("${path.module}/grafana-configmaps/proxy.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
resource "kubernetes_config_map_v1" "statefulsets" {
  metadata {
    name      = "statefulsets"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "statefulsets.json" = "${file("${path.module}/grafana-configmaps/statefulsets.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
resource "kubernetes_config_map_v1" "persistent-volumes" {
  metadata {
    name      = "persistent-volumes"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "persistent-volumes.json" = "${file("${path.module}/grafana-configmaps/persistent-volumes.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
resource "kubernetes_config_map_v1" "prometheous-overview" {
  metadata {
    name      = "prometheous-overview"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "prometheous-overview.json" = "${file("${path.module}/grafana-configmaps/prometheous-overview.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
resource "kubernetes_config_map_v1" "use-method-cluster" {
  metadata {
    name      = "use-method-cluster"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "use-method-cluster.json" = "${file("${path.module}/grafana-configmaps/use-method-cluster.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
resource "kubernetes_config_map_v1" "use-method-node" {
  metadata {
    name      = "use-method-node"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "use-method-node.json" = "${file("${path.module}/grafana-configmaps/use-method-node.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
#compute resources dashboard
resource "kubernetes_config_map_v1" "compute-resources-cluster" {
  metadata {
    name      = "compute-resources-cluster"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "compute-resources-cluster.json" = "${file("${path.module}/grafana-configmaps/compute-resources-cluster.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
resource "kubernetes_config_map_v1" "compute-resources-node-pods" {
  metadata {
    name      = "compute-resources-node-pods"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "compute-resources-node-pods.json" = "${file("${path.module}/grafana-configmaps/compute-resources-node-pods.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
resource "kubernetes_config_map_v1" "compute-resources-pod" {
  metadata {
    name      = "compute-resources-pod"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "compute-resources-pod.json" = "${file("${path.module}/grafana-configmaps/compute-resources-pod.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
resource "kubernetes_config_map_v1" "compute-resources-workload" {
  metadata {
    name      = "compute-resources-workload"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "compute-resources-workload.json" = "${file("${path.module}/grafana-configmaps/compute-resources-workload.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
resource "kubernetes_config_map_v1" "compute-resources-namespace-workloads" {
  metadata {
    name      = "compute-resources-namespace-workloads"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "compute-resources-namespace-workloads.json" = "${file("${path.module}/grafana-configmaps/compute-resources-namespace-workloads.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
resource "kubernetes_config_map_v1" "computer-resources-namespace-pods" {
  metadata {
    name      = "computer-resources-namespace-pods"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "computer-resources-namespace-pods.json" = "${file("${path.module}/grafana-configmaps/computer-resources-namespace-pods.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}

#networking dashboard
resource "kubernetes_config_map_v1" "networking-namespace-pods" {
  metadata {
    name      = "networking-namespace-pods"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "networking-namespace-pods.json" = "${file("${path.module}/grafana-configmaps/networking-namespace-pods.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
resource "kubernetes_config_map_v1" "networking-namespace-workload" {
  metadata {
    name      = "networking-namespace-workload"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "networking-namespace-workload.json" = "${file("${path.module}/grafana-configmaps/networking-namespace-workload.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
resource "kubernetes_config_map_v1" "networking-cluster" {
  metadata {
    name      = "networking-cluster"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "networking-cluster.json" = "${file("${path.module}/grafana-configmaps/networking-cluster.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
resource "kubernetes_config_map_v1" "networking-pods" {
  metadata {
    name      = "networking-pods"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "networking-pods.json" = "${file("${path.module}/grafana-configmaps/networking-pods.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
resource "kubernetes_config_map_v1" "networking-workload" {
  metadata {
    name      = "networking-workload"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "networking-workload.json" = "${file("${path.module}/grafana-configmaps/networking-workload.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}

#Istio dashboard
resource "kubernetes_config_map_v1" "istio-control-plane" {
  metadata {
    name      = "istio-control-plane"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "istio-control-plane.json" = "${file("${path.module}/grafana-configmaps/istio-control-plane.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
resource "kubernetes_config_map_v1" "istio-mesh" {
  metadata {
    name      = "istio-mesh"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "istio-mesh.json" = "${file("${path.module}/grafana-configmaps/istio-mesh.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
resource "kubernetes_config_map_v1" "istio-performance" {
  metadata {
    name      = "istio-performance"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "istio-performance.json" = "${file("${path.module}/grafana-configmaps/istio-performance.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
resource "kubernetes_config_map_v1" "istio-service" {
  metadata {
    name      = "istio-service"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "istio-service.json" = "${file("${path.module}/grafana-configmaps/istio-service.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}
resource "kubernetes_config_map_v1" "istio-workload" {
  metadata {
    name      = "istio-workload"
    namespace = "monitoring"
    labels = {
      grafana_dashboard = "dashboard"
    }
  }
  data = {
    "istio-workload.json" = "${file("${path.module}/grafana-configmaps/istio-workload.json")}"
  }
  depends_on = [
    kubernetes_namespace.monitoring,
    time_sleep.wait_for_kubernetes
  ]
}