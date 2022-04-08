resource "kubernetes_persistent_volume" "pv-mysql-2" {
  metadata {
    name = "pv-mysql-2"

  }
  spec {
    storage_class_name = "manual"
    capacity = {
      storage = "10Gi"
    }

    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
          host_path {
      path = "/data/mysql-volume-2/"
      type = "DirectoryOrCreate"
    }
    }



  }
}



resource "kubernetes_persistent_volume_claim" "pvc-mysql-2" {
  metadata {
    name = "pvc-mysql-2"
    namespace = "dev"
  }
  spec {
    access_modes = ["ReadWriteMany"]
    storage_class_name = "manual"

    resources {
      requests = {
        storage = "5Gi"
      }
    }
    volume_name = "${kubernetes_persistent_volume.pv-mysql-2.metadata.0.name}"
  }
}