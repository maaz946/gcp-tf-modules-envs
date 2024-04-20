##########provider
variable "project" {
  type        = string
  description = "project name"
}
variable "region" {
  type        = string
  description = "region name"
}
variable "bucket" {
  type        = string
  description = "statebucket name"
}
variable "gcp_auth_file" {

}


#######VPC
variable "vpc-name" {
  type        = string
  description = "Name of vpc"
}
variable "vpc-routing-mode" {
  type        = string
  description = "vpc routing mode"
}
variable "vpc-auto-create-subnetworks" {
  type        = bool
  description = "true or false"
}

variable "vpc-delete_default_routes" {
  type        = bool
  description = "delete_default_routes_on_create"
}


########SUBNET
variable "subnet_name" {
  description = "The name of the subnetwork."
  type        = string
}

variable "subnet_ip_cidr_range" {
  description = "The IP CIDR range of the subnetwork."
  type        = string
}

variable "subnet_region" {
  description = "The region where the subnetwork will be created."
  type        = string
  default     = "me-central1"
}

variable "subnet_private_ip_google_access" {
  description = "Whether the VMs in this subnetwork can access Google services without assigned external IP addresses."
  type        = bool
  default     = false
}

variable "subnet_enable_flow_logs" {
  description = "Whether to enable flow logs for the subnetwork."
  type        = bool
  default     = false
}

variable "subnet_log_config" {
  description = "The logging options configuration for the flow logs."
  type = object({
    aggregation_interval = string
    flow_sampling        = number
    metadata             = string
  })
}
variable "subnet_secondary_ranges" {
  description = "List of secondary IP ranges for the subnetwork."
  type = list(object({
    range_name    = string
    ip_cidr_range = string
  }))
  default = []
}


## new not use
variable "subnet-stack-type" {
  type        = string
  description = "choose IPV4_ONLY"
  default = "IPV4_ONLY"
}



###########router
variable "router-name" {
  type        = string
  description = "router-name"
}

########### nat
variable "nat-router-name" {
  type        = string
  description = "nat-router-name"
}

variable "nat-router-subnetwork-ip-ranges" {
  type        = string
  description = "nat-router-subnetwork-ip-ranges"
}

variable "nat-router-ip-allocate-option" {
  type        = string
  description = "nat-router-ip-allocate-option"
}

variable "nat-router-source-ip-ranges" {
  type        = list(any)
  description = "nat-router-source-ip-ranges"
}

###### nat address

variable "nat-address-name" {
  type        = string
  description = "nat-address-name"
}
variable "nat-address-type" {
  type        = string
  description = "nat-address_type"
}
variable "nat-address-network_tier" {
  type        = string
  description = "nat-address-network_tier"
}

########## firewall

# variable "firewall-name-allow-ssh" {
#   type        = string
#   description = "nat-address-network_tier"
# }

# variable "firewall-source-range" {
#   description = "firewall-source-range in list"
#   type        = list(any)
#   default     = []
# }


variable "firewall_rules" {
  description = "Firewall rules configuration"
  type = list(object({
    name         = string
    ports        = list(string)
    protocols    = list(string)
    source_ips   = list(string)
  }))
}

variable "zone" {
  description = "zone for node."
  type        = string
  default     = null
}

############################## VM

variable "create_vm" {
  description = "A boolean flag to control whether the VM instances should be created"
  type        = bool
}
variable "vm_instance_static" {
  description = "A boolean flag to control whether the VM instances should be created"
  type        = string
}

variable "vm_maaz_password" {
  description = "Password for the maaz user"
  type        = string
}

variable "vm_backend_access_password" {
  description = "Password for the backend_access user"
  type        = string
}


variable "vm_instances" {
  description = "Configuration for each VM instance"
  type = map(object({
    device_name          = string
    boot_disk_image      = string     #### "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20230907"
    boot_disk_size       = number
    boot_disk_type       = string
    machine_type         = string
    vm_metadata          = map(string)
    instance_name        = string
    subnetwork           = string  ####"projects/kistpayproject/regions/me-central1/subnetworks/devprivate"
    automatic_restart    = bool   ##false
    on_host_maintenance  = string
    preemptible          = bool
    provisioning_model   = string
    service_account_email = string
    service_account_scopes = list(string)
    enable_integrity_monitoring = bool
    enable_secure_boot   = bool
    enable_vtpm          = bool
    instance_tags        = list(string)
    instance_zone        = string
  }))
}
