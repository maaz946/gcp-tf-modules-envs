project     = "kistpayproject"
region      = "me-central1"
bucket = "kistpay-gcp-terraform"
gcp_auth_file = "/gcpuser.json"

vpc-name                    = "devkistpayvpc"
vpc-routing-mode            = "REGIONAL"
vpc-auto-create-subnetworks = false
vpc-delete_default_routes   = false
# vpc-auto-createsubnetworks  = false


# subnet-name                      = "devprivate"
# subnet-ipcidr-range              = "10.0.0.0/18"
# subnet_private_ip-access         = true
# subnet-pod-second-range-name     = "k8s-pod-range"
# subnet-pod-second-range          = "10.48.0.0/14"
# subnet-second-service-range-name = "k8s-service-range"
# subnet-second-service-range      = "10.52.0.0/20"
#####################
subnet_name                     = "devprivate"
subnet_ip_cidr_range            = "110.0.0.0/18"
subnet_region                   = "me-central1"
subnet_private_ip_google_access = true
subnet_enable_flow_logs         = true

subnet_log_config = {
  aggregation_interval = "INTERVAL_5_SEC"
  flow_sampling        = 0.5
  metadata             = "INCLUDE_ALL_METADATA"
}

subnet_secondary_ranges = [
  {
    range_name    = "pod-range"
    ip_cidr_range = "10.0.1.0/24"
  },
  {
    range_name    = "service-range"
    ip_cidr_range = "10.0.2.0/24"
  }
]


router-name = "devrouter"


nat-router-name                 = "devnat"
nat-router-subnetwork-ip-ranges = "LIST_OF_SUBNETWORKS"
nat-router-ip-allocate-option   = "MANUAL_ONLY"
nat-router-source-ip-ranges     = ["ALL_IP_RANGES"]
nat-address-name                = "devnat"
nat-address-type                = "EXTERNAL"
nat-address-network_tier        = "PREMIUM"


# firewall-name-allow-ssh = "allow-ssh"
# firewall-source-range   = ["0.0.0.0/0"]

firewall_rules = [
  {
    name       = "allow-ssh-rdp"
    ports      = ["22", "3389"]
    protocols  = ["tcp"]
    source_ips = ["2.23.213.2/32", "23.5.66.77/32"]
  }
  // Add more rules as needed
]



vm_instance_static=   "windowsvm-ip"

vm_instances = {
  "vm1" = {
    device_name          = "instance-1"
    vm_instance_static   = "windowstestvm-ip"
    boot_disk_image      = "projects/windows-cloud/global/images/windows-server-2022-dc-v20230913"
    boot_disk_size       = 50
    boot_disk_type       = "pd-balanced" #pd-ssd
    machine_type         = "n1-standard-1"
    vm_metadata          = {
      "windows-startup-script-ps1" = <<-EOF
        # PowerShell script for creating Windows users dynamically

        # Creating user 'maaz'
        $maazPassword = ConvertTo-SecureString -AsPlainText "PLACEHOLDER_MAAS_PASS" -Force
        New-LocalUser -Name "maaz" -Password $maazPassword -FullName "Maaz" -Description "Maaz User Account"
        Add-LocalGroupMember -Group "Administrators" -Member "maaz"

        # Creating user 'backend_access'
        $backendAccessPassword = ConvertTo-SecureString -AsPlainText "PLACEHOLDER_BACKEND_ACCESS_PASS" -Force
        New-LocalUser -Name "backend_access" -Password $backendAccessPassword -FullName "Backend Access" -Description "Backend Access User Account"
        Add-LocalGroupMember -Group "Administrators" -Member "backend_access"

        # Additional setup can be added here
      EOF
    }
    instance_name        = "windowsvm"
    subnetwork           = "projects/kistpayproject/regions/me-central1/subnetworks/devprivate"
    automatic_restart    = false
    on_host_maintenance  = "MIGRATE"
    preemptible          = false
    provisioning_model   = "STANDARD"
    service_account_email = "144279972459-compute@developer.gserviceaccount.com"
    service_account_scopes = [
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring.write",
    "https://www.googleapis.com/auth/service.management.readonly",
    "https://www.googleapis.com/auth/servicecontrol",
    "https://www.googleapis.com/auth/trace.append",
  ]
    enable_integrity_monitoring = true
    enable_secure_boot   = true
    enable_vtpm          = false
    instance_tags        = ["http-server", "https-server"]
    instance_zone        = "me-central1-a"
  },
  # Add more VM instances as needed
}


