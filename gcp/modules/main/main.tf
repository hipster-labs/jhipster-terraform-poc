module "enable_gcp_apis" {
  source = "../enable_gcp_apis"

  project = var.project
  apis_to_enable = ["compute.googleapis.com"]
}

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 2.5"

  project_id   = var.project
  network_name = var.network
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = "subnet-01"
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = var.region
      description           = "JHipster subnet 01"
    },
    {
      subnet_name           = "subnet-02"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = var.region
      description           = "JHipster subnet 02"
    },
    {
      subnet_name           = "subnet-03"
      subnet_ip             = "10.10.30.0/24"
      subnet_region         = var.region
      description           = "JHipster subnet 03"
    }
  ]

  routes = [
    {
      name                   = "egress-internet"
      description            = "route through IGW to access internet"
      destination_range      = "0.0.0.0/0"
      tags                   = "egress-inet"
      next_hop_internet      = "true"
    }
  ]

  depends_on = [module.enable_gcp_apis]
}

resource "google_service_account" "gke-nodes-service_account" {
  account_id   = "gke-nodes"
  display_name = "GKE nodes Service account"
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = var.project
  name                       = "${var.name}-kubernetes-cluster"
  region                     = var.region
  zones                      = [var.zone] // TODO add multi-zone option as it is more expense
  network                    = var.network
  subnetwork                 = "subnet-01"
  ip_range_pods              = "subnet-02"
  ip_range_services          = "subnet-03"
  http_load_balancing        = true
  horizontal_pod_autoscaling = true
  network_policy             = true

  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "e2-standard-2"
      min_count          = 1
      max_count          = 5
      local_ssd_count    = 0
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = google_service_account.gke-nodes-service_account.email
      preemptible        = false
      initial_node_count = 2
    }
  ]

  node_pools_oauth_scopes = {
    all = []

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}