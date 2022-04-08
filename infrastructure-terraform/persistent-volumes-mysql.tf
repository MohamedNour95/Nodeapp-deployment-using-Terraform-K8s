resource "kubernetes_persistent_volume" "pv-mysql" {
  metadata {
    name = "pv-mysql"

  }
  spec {
    storage_class_name = "manual"
    capacity = {
      storage = "10Gi"
    }

    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
          host_path {
      path = "/data/mysql-volume/"
      type = "DirectoryOrCreate"
    }
    }



  }
}



resource "kubernetes_persistent_volume_claim" "pvc-mysql" {
  metadata {
    name = "pvc-mysql"
    namespace = "test"
  }
  spec {
    access_modes = ["ReadWriteMany"]
    storage_class_name = "manual"

    resources {
      requests = {
        storage = "5Gi"
      }
    }
    volume_name = "${kubernetes_persistent_volume.pv-mysql.metadata.0.name}"
  }
}