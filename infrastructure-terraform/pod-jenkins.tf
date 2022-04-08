resource "kubernetes_pod" "jenkins" {
  metadata {
    name      = "jenkins-example"
    namespace = "build"
    labels = {
      app = "jenkins-server"
    }
  }

  spec {
    container {     
      image = "mohamednour95/jenkins_modified"
      name  = "jenkins"
    
  
      port {
        container_port = 8080
      }
      volume_mount {
        name       = "jenkins-home"
        mount_path = "/var/jenkins_home"
      }
      volume_mount {
        name       = "kubectl"
        mount_path = "/var/kubectl"
      }
  
      volume_mount {
        name       = "docker"
        mount_path = "/usr/bin/docker"
      }
      volume_mount {
        name       = "dockersock"
        mount_path = "/var/run/docker.sock"
      }

    }
    # to make a token to service account
    service_account_name            = "jenkins"
    automount_service_account_token = "true"
    # volume for jenkins
    volume {
      name = "jenkins-home"
      persistent_volume_claim {
        claim_name = "pvc-jenkins"
      }
    }

    security_context {
      fs_group = "1000"
    }
   

  # Node-port-service for jenkins
resource "kubernetes_service" "jenkins-service" {
  metadata {
    name      = "jenkins-service"
    namespace = "build"
  }
  spec {
    selector = {
      app = "${kubernetes_pod.jenkins.metadata.0.labels.app}"
    }
    port {
      port        = "8080"
      target_port = "8080"
      node_port   = "31000"
    }
    type = "NodePort"
  }
}
