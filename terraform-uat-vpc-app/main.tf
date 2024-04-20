module "uat-vpc" {
  source                      = "app.terraform.io/SoftKistpay/module/gcp"
  bucket                 = var.bucket
  # zone=var.zone
  version                     = "0.0.23"
  gcp_auth_file= var.gcp_auth_file
  project                     = var.project
  region                      = var.region
  vpc-name                    = var.vpc-name
  vpc-routing-mode            = var.vpc-routing-mode
  vpc-auto-create-subnetworks = var.vpc-auto-create-subnetworks
  #vpc-auto-create-subnetworks#vpc-auto-createsubnetworks         = var.vpc-auto-create-subnetworks
  vpc-delete_default_routes = var.vpc-delete_default_routes
 
 
  subnet_name               = var.subnet_name
  subnet_ip_cidr_range       = var.subnet_ip_cidr_range
  # subnet_private_ip-access         = var.subnet_private_ip-access
  subnet_region=var.subnet_region
  subnet_private_ip_google_access    = var.subnet_private_ip_google_access
  subnet_enable_flow_logs=var.subnet_enable_flow_logs
  subnet_log_config=var.subnet_log_config
  subnet_secondary_ranges=var.subnet_secondary_ranges

  router-name                      = var.router-name
  
  nat-router-name = var.nat-router-name
  nat-router-subnetwork-ip-ranges = var.nat-router-subnetwork-ip-ranges
  nat-router-ip-allocate-option   = var.nat-router-ip-allocate-option
  nat-router-source-ip-ranges         = var.nat-router-source-ip-ranges
  nat-address-name                    = var.nat-address-name
  nat-address-type                    = var.nat-address-type
  nat-address-network_tier            = var.nat-address-network_tier
  
  # firewall-name-allow-ssh             = var.firewall-name-allow-ssh
  # firewall-source-range               = var.firewall-source-range
  firewall_rules                      = var.firewall_rules

  ########VM
 
  create_vm             = var.create_vm
  vm_instance_static    = var.vm_instance_static
  vm_maaz_password      = var.vm_maaz_password
  vm_backend_access_password = var.vm_backend_access_password
  vm_instances=var.vm_instances  #########

}
