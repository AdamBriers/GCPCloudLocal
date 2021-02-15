resource "google_compute_instance" "this" {
  name = var.instance_name

  allow_stopping_for_update = var.allow_stopping_for_update
  project                   = var.project
  machine_type              = var.machine_type
  tags                      = var.instance_tags
  zone                      = var.zone

  boot_disk {
    initialize_params {
      image = var.os_image
      size  = var.boot_disk_size
      type  = var.boot_disk_type
    }

    auto_delete = var.boot_disk_auto_delete
  }

  metadata_startup_script = var.metadata_startup_script

  lifecycle {
    ignore_changes = [
      boot_disk.0.initialize_params.0.image,
      labels
    ]
  }

  network_interface {
    network            = var.network
    subnetwork         = var.subnetwork
    subnetwork_project = var.subnetwork_project
  }

  service_account {
    scopes = concat(var.instance_scope, ["logging-write", "monitoring-write", "storage-ro"])
    email  = var.gcp_instance_sa_email
  }

  scheduling {
    preemptible         = var.preemptible
    on_host_maintenance = var.on_host_maintenance
    automatic_restart   = var.automatic_restart
  }

  dynamic "guest_accelerator" {
    for_each = [var.guest_accelerator]

    content {
      type  = lookup(guest_accelerator.value, "type", "")
      count = lookup(guest_accelerator.value, "count", 0)
    }
  }

  labels = var.labels
}
