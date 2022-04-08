resource "kubernetes_role" "role-2" {
   metadata {
      name = "test-role"
      namespace = "${kubernetes_namespace.minikube-namespace-3.metadata.0.name}"
   }

    rule {
       api_groups = ["*"]
       resources = ["*"]
       verbs = ["*"]
    }
}


