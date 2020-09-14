# Terragrunt Environment configuration

remote_state {
  backend = "gcs"

  config = {
    bucket  = "tf-remote-state-lhmat"
    project = "jhipster-terraform-poc"
    location = "europe-west1"
    prefix  = path_relative_to_include()
  }
}
