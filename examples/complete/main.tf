locals {
  region       = "asia-south1"
  environment  = ""
  name         = ""
  project_name = "atmosly-439606"
}

module "vpc" {
  source        = "../../"
  name          = local.name
  project_name  = local.project_name
  environment   = local.environment
  region        = local.region
  ip_cidr_range = "10.128.0.0/16"   # for public subnet only
  private_ip_cidr_range = ["10.130.0.0/16" , "10.134.0.0/16"]  # for private subnet .
  lb_ip_cidr_range = "10.131.0.0/16"   # for loadbalancer proxy subnet.
  secondary_ip_range = [
    {
      range_name    = "tf-test-secondary-range1"
      ip_cidr_range = "192.168.10.0/24"
    },
    {
      range_name    = "tf-test-secondary-range2"
      ip_cidr_range = "192.168.11.0/24"
    }
  ]
  private_ip_google_access   = true
  private_ipv6_google_access = true
  enable_nat_gateway         = true
  db_private_access          = true
  create_vpn                 = false
  vpc_flow_logs              = true


}
