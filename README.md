# JHipster Terraform POC

Goal: provide Terraform scripts to create the cloud infrastructure to deploy a JHipster microservice architecture on Kubernetes.

## Required tools

- [Terraform](https://www.terraform.io/)
- [Terragrunt](https://terragrunt.gruntwork.io/)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

### GCP

- [gcloud CLI](https://cloud.google.com/sdk/gcloud)

### Azure

- [az CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

### AWS

- [aws CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)

## Quickstart instruction

### GCP

Login to GCP and import temporary auth token to your shell environment:

    gcloud auth application-default login 
    export GOOGLE_OAUTH_ACCESS_TOKEN=$(gcloud auth print-access-token)
    
Apply the terraform:

    cd live/gcp-demo/main
    terragrunt apply
