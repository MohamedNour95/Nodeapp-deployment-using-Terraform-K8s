resource "kubernetes_pod" "nexus" {
  metadata {
    name = "nexus-example"
    namespace = "build"  
    labels = {
      app = "nexus-server"
    } 
  }

  spec {
    security_context {
          fs_group = "200"
        }
    container {
      image = "sonatype/nexus3:3.26.1"
      name  = "nexus"

      port {
        container_port = 8081
      }
      port {
        container_port = 8123
      }
      volume_mount {
              name = "nexus-home"
              mount_path = "/nexus-data"
      }

    }
    volume {
          name = "nexus-home"
          persistent_volume_claim {
          claim_name = "pvc-nexus"
    } 
    }
  }
}


resource "kubernetes_service" "nexus-service" {
  metadata {
    name = "nexus-service"
    namespace = "build"
  }
  spec {
    selector = {
         app = "${kubernetes_pod.nexus.metadata.0.labels.app}"
          }
    port {
      name = "node-port"
      port = 8081
      target_port = 8081
      node_port = 32000
    }
   port {
      name = "http-port"
      port = 8123
      target_port = 8123
      node_port = 30000
    }
    type = "NodePort"
   }
}

