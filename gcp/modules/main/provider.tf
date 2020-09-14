terraform {
  backend "gcs" {
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  //credentials = ""
  project     = var.project
  region      = var.region
  zone        = var.zone
  version     = "3.38.0"
}
