# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat
resource "google_compute_router_nat" "nat" {
  name   = var.nat-router-name
  router = google_compute_router.router.name

  source_subnetwork_ip_ranges_to_nat = var.nat-router-subnetwork-ip-ranges
  nat_ip_allocate_option             = var.nat-router-ip-allocate-option

  subnetwork {
    name                    = google_compute_subnetwork.private.id
    source_ip_ranges_to_nat = var.nat-router-source-ip-ranges
  }

  nat_ips = [google_compute_address.nat.self_link]
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address
resource "google_compute_address" "nat" {
  name         = var.nat-address-name
  address_type = var.nat-address-type
  network_tier = var.nat-address-network_tier

  depends_on = [google_project_service.compute]
}
