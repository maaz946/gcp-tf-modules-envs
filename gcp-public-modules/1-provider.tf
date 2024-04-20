# https://www.terraform.io/language/settings/backends/gcs
provider "google" {
  project = var.project
  region  = var.region
  zone=var.zone
  # credentials = var.gcp_auth_file
  credentials = file(var.gcp_auth_file)
}


provider "google-beta" {
  project = var.project
  region  = var.region
  zone=var.zone
  # credentials = var.gcp_auth_file
  credentials = file(var.gcp_auth_file)
}
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}
# provider "helm" {
#   kubernetes {
#     config_path = "/home/tfc-agent/.kube/config"
#   }
# }
