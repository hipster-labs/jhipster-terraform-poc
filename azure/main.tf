module "main" {
  source      = "./modules/main"
  location    = "${var.location}"
  app_name    = "${var.app_name}"
  environment = "${var.environment}"
  env_version = "${var.env_version}"
  rg_name     = "${var.rg_name}"
}

module "network" {
  source   = "./modules/network"
  location = "${var.location}"
  app_name = "${var.app_name}"
  rg_name  = "${var.rg_name}"
}

module "vk8s" {
  source         = "./modules/vk8s"
  rg_name        = "${var.rg_name}"
  location       = "${var.location}"
  environment    = "${var.environment}"
  env_version    = "${var.env_version}"
  cluster_name   = "${var.cluster_name}"
  app_name       = "${var.app_name}"
  nb_instances   = "${var.nb_instances}"
  vm_size        = "${var.vm_size}"
  vm_disk_size   = "${var.vm_disk_size}"
  os_type        = "${var.os_type}"
  k8s_version    = "${var.k8s_version}"
  admin_username = "${var.admin_username}"
  network_plugin = "${var.network_plugin}"
  dns_prefix     = "${var.dns_prefix}"
}

module "acr" {
  source         = "./modules/acr"
  container_name = "${var.container_name}"
  rg_name        = "${var.rg_name}"
  location       = "${var.location}"
  environment    = "${var.environment}"
  owner          = "${var.owner}"
}

module "postgres" {
  source              = "./modules/postgres"
  name                = "${var.app_name}"
  location            = "${var.location}"
  resource_group_name = "${var.rg_name}"
}

module "mysql" {
  source              = "./modules/mysql"
  name                = "${var.app_name}"
  location            = "${var.location}"
  resource_group_name = "${var.rg_name}"
}

