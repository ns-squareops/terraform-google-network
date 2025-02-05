/******************************************
	Subnet configuration
 *****************************************/
resource "google_compute_subnetwork" "LB_subnet" {
  name          = var.name
  ip_cidr_range = var.lb_ip_cidr_range
  region        = var.region
  network = var.network_name
  project = var.project_id

  purpose    = var.purpose
  role       = var.role
  stack_type = var.stack_type
}
