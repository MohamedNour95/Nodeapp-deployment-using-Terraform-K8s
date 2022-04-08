resource "kubernetes_role_binding" "dev-binding" {
  metadata {
    name = "role-binding-dev"
    namespace = "dev"
   
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "dev-role"
  

  }
  subject {
    kind      = "ServiceAccount"
    name      = "jenkins"
    namespace = "build"
  }
}