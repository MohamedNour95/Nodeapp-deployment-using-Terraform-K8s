provider "kubernetes" {
  config_context_cluster   = "minikube"
}

resource "kubernetes_namespace" "minikube-namespace-1" {
  metadata {
        name = "dev"
  }
}

resource "kubernetes_namespace" "minikube-namespace-2" {
  metadata {
        name = "build"
  }
}

resource "kubernetes_namespace" "minikube-namespace-3" {
  metadata {
        name = "test"
  }
}

