resource "kubernetes_pod" "mysql" {
  metadata {
    name = "mysql-example"
    namespace = "test"  
    labels = {
      app = "test-server"
    } 
  }

  spec {
    container {
      image = "mysql/mysql-server"
      name  = "mysql"

      port {
        container_port = 3306
      }
      env {
         name = "MYSQL_ROOT_PASSWORD"
         value = var.MYSQL_ROOT_PASSWORD
      }
      env{
         name ="MYSQL_DATABASE"
         value = var.MYSQL_DATABASE
      }
      env{
         name = "MYSQL_USER"
         value = var.MYSQL_USER
      }
      env{
         name = "MYSQL_PASSWORD"
         value = var.MYSQL_PASSWORD
      }
      volume_mount {
              name = "mysql-home"
              mount_path = "/var/lib/mysql"
      }

    }
   volume {
          name = "mysql-home"
          persistent_volume_claim {
          claim_name = "pvc-mysql"
    } 
    }
  }
}

# mysql pod on namespace dev

resource "kubernetes_pod" "mysql-2" {
  metadata {
    name = "mysql-example-2"
    namespace = "dev"
    labels = {
      app = "test-server"
    }
  }

  spec {
    container {
      image = "mysql/mysql-server"
      name  = "mysql"

      port {
        container_port = 3306
      }
      env {
         name = "MYSQL_ROOT_PASSWORD"
         value = "admin"
      }
      env{
         name ="MYSQL_DATABASE"
         value = "admin"
      }
      env{
         name = "MYSQL_USER"
         value = "admin"
      }
      env{
         name = "MYSQL_PASSWORD"
         value = "admin"
      }

       volume_mount {
              name = "mysql-2-home"
              mount_path = "/var/lib/mysql2"
      }

    }
    volume {
          name = "mysql-2-home"
          persistent_volume_claim {
          claim_name = "pvc-mysql-2"
           } 
    }
  
 }
}


