# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service
resource "google_project_service" "compute" {
  service = "compute.googleapis.com" #var.vpc-project-service-compute
}

resource "google_project_service" "container" {
  service = "container.googleapis.com" #var.vpc-project-service-container
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
resource "google_compute_network" "main" {
  name         = var.vpc-name
  routing_mode = var.vpc-routing-mode
  auto_create_subnetworks         = var.vpc-auto-create-subnetworks
  mtu                             = 1460
  delete_default_routes_on_create = var.vpc-delete_default_routes

  depends_on = [
    google_project_service.compute,
    google_project_service.container
  ]
}