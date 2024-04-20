# # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall
# resource "google_compute_firewall" "allow-ssh" {
#   name    = var.firewall-name-allow-ssh
#   network = google_compute_network.main.name

#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }

#   source_ranges = var.firewall-source-range
# }

resource "google_compute_firewall" "dynamic_firewall" {
  for_each = { for idx, fr in var.firewall_rules : idx => fr }

  name    = each.value.name
  network = google_compute_network.main.name

  dynamic "allow" {
    for_each = toset([for p in each.value.protocols : {
      protocol = p
      ports    = each.value.ports
    }])

    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }

  source_ranges = each.value.source_ips
}
