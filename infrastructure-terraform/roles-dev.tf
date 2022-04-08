resource "kubernetes_role" "role-1" {
   metadata {
      name = "dev-role"
      namespace = "${kubernetes_namespace.minikube-namespace-1.metadata.0.name}"
   }

    rule {
       api_groups = ["*"]
       resources = ["*"]
       verbs = ["*"]
    }
}


