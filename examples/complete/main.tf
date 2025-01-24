locals {
  region       = "asia-south1"
  environment  = ""
  name         = ""
  project_name = ""

  # Define the private CIDR ranges only once
  private_ip_cidr_range = [
    "", # Private subnet 1
    ""  # Private subnet 2
  ]
}

module "vpc" {
  source                = "../../"
  name                  = local.name
  project_name          = local.project_name
  environment           = local.environment
  region                = local.region
  ip_cidr_range         = ""                          # Public subnet CIDR
  private_ip_cidr_range = local.private_ip_cidr_range # Pass CIDR ranges for private subnets
  lb_ip_cidr_range      = ""                          # Load balancer proxy subnet

  # Dynamically generate secondary IP ranges
  secondary_ip_range = [
    for idx, cidr in local.private_ip_cidr_range : {
      range_name    = format("tf-test-secondary-range%d", idx + 1)
      ip_cidr_range = format("192.168.%d.0/24", idx + 10) # Starts from 192.168.10.0/24, 192.168.11.0/24, etc.
    }
  ]
  private_ip_google_access = true
  enable_nat_gateway       = true
  db_private_access        = true
  create_vpn               = false
  vpc_flow_logs            = true
}
