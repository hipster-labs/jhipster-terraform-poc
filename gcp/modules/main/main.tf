module "enable_gcp_apis" {
  source = "../enable_gcp_apis"

  project = var.project
  apis_to_enable = ["compute.googleapis.com", "servicenetworking.googleapis.com"]
}

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 2.5"

  project_id   = var.project
  network_name = var.network
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = "kubernetes-subnet"
      subnet_ip             = "10.5.0.0/20"
      subnet_region         = var.region
      description           = "JHipster subnet 01"
    }
  ]

  secondary_ranges = {
    "kubernetes-subnet" = [
      {
        range_name    = "kubernetes-pod-subnet"
        ip_cidr_range = "10.0.0.0/14"
      },
      {
        range_name    = "kubernetes-service-subnet"
        ip_cidr_range =  "10.4.0.0/19"
      },
    ]
  }
  /*
  ,
    {
      subnet_name           =
      subnet_ip             =
      subnet_region         = var.region
      description           = "JHipster subnet 02"
    },
    {
      subnet_name           =
      subnet_ip             =
      subnet_region         = var.region
      description           = "JHipster subnet 03"
    }
    */

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
  network                    = module.vpc.network_name
  subnetwork                 = "kubernetes-subnet"
  ip_range_pods              = module.vpc.subnets_secondary_ranges[0][0].range_name
  ip_range_services          = module.vpc.subnets_secondary_ranges[0][1].range_name
  http_load_balancing        = true
  horizontal_pod_autoscaling = true
  network_policy             = true
  remove_default_node_pool   = true

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

module "database" {
  source = "../database"

  name   = var.name
  region = var.region
  database_version = "POSTGRES_12"
  network_self_link = module.vpc.network_self_link
  database_name = "jhipster"
  database_user = "jhipster"
  database_password = "jhipster"

  depends_on = [module.enable_gcp_apis]
}