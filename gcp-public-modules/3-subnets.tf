# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
# resource "google_compute_subnetwork" "private" {
#   name          = var.subnet-name
#   ip_cidr_range = var.subnet-ipcidr-range
#   region                   = "me-central1"
#   network                  = google_compute_network.main.id
#   private_ip_google_access = var.subnet_private_ip-access
#   enable_flow_logs=var.subnet-flow-log
#   log_config{
#     enable_flow_logs = var.subnet-flow-log
#   } #var.log_config
#   stack_type=var.subnet-stack-type

#   secondary_ip_range {
#     range_name    = var.subnet-pod-second-range-name
#     ip_cidr_range = var.subnet-pod-second-range
#   }
#   secondary_ip_range {
#     range_name    = var.subnet-second-service-range-name
#     ip_cidr_range = var.subnet-second-service-range
#   }
# }


resource "google_compute_subnetwork" "private" {
  name                      = var.subnet_name
  ip_cidr_range             = var.subnet_ip_cidr_range
  region                    = var.subnet_region
  network                   = google_compute_network.main.id
  private_ip_google_access  = var.subnet_private_ip_google_access

  dynamic "log_config" {
    for_each = var.subnet_enable_flow_logs ? [1] : []
    content {
      # include the appropriate flow log configuration settings here
      aggregation_interval = lookup(var.subnet_log_config, "aggregation_interval", null)
      flow_sampling        = lookup(var.subnet_log_config, "flow_sampling", null)
      metadata             = lookup(var.subnet_log_config, "metadata", "INCLUDE_ALL_METADATA")
    }
  }

  dynamic "secondary_ip_range" {
    for_each = var.subnet_secondary_ranges
    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }
}
