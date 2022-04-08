
resource "kubernetes_service_account" "jenkins-account" {
  metadata {
    name = "jenkins"
    namespace = "build"
  }
}