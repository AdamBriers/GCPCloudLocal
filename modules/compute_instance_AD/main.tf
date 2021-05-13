resource "google_compute_instance" "this" {
  for_each = var.instance
  name = each.key

  allow_stopping_for_update = var.allow_stopping_for_update
  project                   = each.value.project
  machine_type              = each.value.machine_type
  tags                      = each.value.instance_tags
  zone                      = each.value.zone

  boot_disk {
    initialize_params {
      image = each.value.os_image
      size  = each.value.boot_disk_size
      type  = each.value.boot_disk_type
    }

    auto_delete = var.boot_disk_auto_delete
  }

  metadata_startup_script = each.value.metadata_startup_script

  lifecycle {
    ignore_changes = [
      boot_disk.0.initialize_params.0.image,
      labels
    ]
  }

  network_interface {
    network            = each.value.network
    subnetwork         = each.value.subnetwork
    subnetwork_project = var.subnetwork_project
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  service_account {
    scopes = concat(each.value.instance_scope, ["logging-write", "monitoring-write", "storage-ro"])
    email  = each.value.gcp_instance_sa_email
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

  labels = each.value.labels
}

resource "google_compute_address" "static" {
  for_each = var.instance

  name         = "${each.key}-internal-address"
  subnetwork   = each.value.subnetwork
  address_type = "INTERNAL"
  address      = each.value.ip_address
}