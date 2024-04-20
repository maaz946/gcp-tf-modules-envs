resource "google_compute_address" "static_ip" {
  for_each = var.create_vm ? var.vm_instances : {}

  name   = each.value.vm_instance_static
  region = var.region
}

resource "google_compute_instance" "windows" {
  for_each = var.create_vm ? var.vm_instances : {}

  name = each.value.instance_name
  zone = each.value.instance_zone

  boot_disk {
    auto_delete = true
    device_name = each.value.device_name

    initialize_params {
      image = each.value.boot_disk_image
      size  = each.value.boot_disk_size
      type  = each.value.boot_disk_type
    }
  }

  can_ip_forward      = false
  deletion_protection = true
  enable_display      = false
  labels              = { goog-ec-src = "vm_add-tf" }
  machine_type        = each.value.machine_type

  network_interface {
    subnetwork = each.value.subnetwork
    access_config {
      nat_ip = google_compute_address.static_ip[each.key].address
    }
  }

  scheduling {
    automatic_restart   = each.value.automatic_restart
    on_host_maintenance = each.value.on_host_maintenance
    preemptible         = each.value.preemptible
    provisioning_model  = each.value.provisioning_model
  }

  service_account {
    email  = each.value.service_account_email
    scopes = each.value.service_account_scopes
  }

  shielded_instance_config {
    enable_integrity_monitoring = each.value.enable_integrity_monitoring
    enable_secure_boot          = each.value.enable_secure_boot
    enable_vtpm                 = each.value.enable_vtpm
  }

  tags = each.value.instance_tags
  depends_on = [google_compute_subnetwork.private]
}
