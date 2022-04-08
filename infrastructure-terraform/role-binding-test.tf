resource "kubernetes_role_binding" "test-binding" {
  metadata {
    name = "role-binding-test"
    namespace = "test"
   
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "test-role"
  

  }
  subject {
    kind      = "ServiceAccount"
    name      = "jenkins"
    namespace = "build"
  }
}