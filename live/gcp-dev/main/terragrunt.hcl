terraform {
  source = "file::../../../gcp/modules//main"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  project = "jhipster-terraform-poc"
  name = "jhipster-test1"
  region = "europe-west1"
  zone = "europe-west1-b"
  network = "jhipster-vpc"
}