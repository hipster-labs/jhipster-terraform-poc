#!/bin/sh

NOW="$(date +'%B %d, %Y')"
RED="\033[1;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
PURPLE="\033[1;35m"
CYAN="\033[1;36m"
WHITE="\033[1;37m"
RESET="\033[0m"

export TF_VAR_ENV="DevOps"
export TF_VAR_COMPONENT="JHipster_Azure"

echo "----------------------------------------------------"
echo -n "| ${CYAN} Component: $TF_VAR_COMPONENT ${RESET}"
echo -n "| ${CYAN} Environment: $TF_VAR_ENV ${RESET}"
echo "----------------------------------------------------"

if [ $1 == "-init" ]; then
    echo "----------------------------------------------------"
    echo -n "| ${GREEN} Running terraform init ... ${RESET}"
    echo "----------------------------------------------------"
    terragrunt init 
    terragrunt get
fi

if [ $1 == "-plan" ]; then
    echo "----------------------------------------------------"
    echo -n "| ${GREEN} Running terraform plan ... ${RESET}"
    echo "----------------------------------------------------"
    terragrunt plan -var-file=./envs/values.tfvars
fi

if [ $1 == "-plan-main" ]; then
    echo "----------------------------------------------------"
    echo -n "| ${GREEN} Running terraform plan ... ${RESET}"
    echo "----------------------------------------------------"
    terragrunt plan -var-file=./envs/values.tfvars -target module.main
fi

if [ $1 == "-plan-network" ]; then
    echo "----------------------------------------------------"
    echo -n "| ${GREEN} Running terraform plan ... ${RESET}"
    echo "----------------------------------------------------"
    terragrunt plan -var-file=./envs/values.tfvars -target module.network
fi

if [ $1 == "-plan-acr" ]; then
    echo "----------------------------------------------------"
    echo -n "| ${GREEN} Running terraform plan ... ${RESET}"
    echo "----------------------------------------------------"
    terragrunt plan -var-file=./envs/values.tfvars -target module.acr
fi

if [ $1 == "-plan-vk8s" ]; then
    echo "----------------------------------------------------"
    echo -n "| ${GREEN} Running terraform plan ... ${RESET}"
    echo "----------------------------------------------------"
    terragrunt plan -var-file=./envs/values.tfvars -target module.vk8s
fi

if [ $1 == "-plan-postgres" ]; then
    echo "----------------------------------------------------"
    echo -n "| ${GREEN} Running terraform plan ... ${RESET}"
    echo "----------------------------------------------------"
    terragrunt plan -var-file=./envs/values.tfvars -target module.postgres
fi

if [ $1 == "-plan-mysql" ]; then
    echo "----------------------------------------------------"
    echo -n "| ${GREEN} Running terraform plan ... ${RESET}"
    echo "----------------------------------------------------"
    terragrunt plan -var-file=./envs/values.tfvars -target module.mysql
fi

if [ $1 == "-apply" ]; then
    echo "----------------------------------------------------"
    echo -n "| ${GREEN} Running terraform apply ... ${RESET}"
    echo "----------------------------------------------------"
    terragrunt apply -var-file=./envs/values.tfvars -auto-approve
fi

if [ $1 == "-apply-main" ]; then
    echo "----------------------------------------------------"
    echo -n "| ${GREEN} Running terraform apply ... ${RESET}"
    echo "----------------------------------------------------"
    terragrunt apply -var-file=./envs/values.tfvars -target module.eradah_network_main -auto-approve
fi

if [ $1 == "-apply-service" ]; then
    echo "----------------------------------------------------"
    echo -n "| ${GREEN} Running terraform apply ... ${RESET}"
    echo "----------------------------------------------------"
    terragrunt apply -var-file=./envs/values.tfvars -target module.eradah_network -auto-approve
fi

if [ $1 == "-destroy-main" ]; then
    echo "----------------------------------------------------"
    echo -n "| ${GREEN} Running terraform apply ... ${RESET}"
    echo "----------------------------------------------------"
    terragrunt destroy -var-file=./envs/values.tfvars -target module.eradah_network_main -auto-approve
fi

if [ $1 == "-destroy-service" ]; then
    echo "----------------------------------------------------"
    echo -n "| ${GREEN} Running terraform apply ... ${RESET}"
    echo "----------------------------------------------------"
    terragrunt destroy -var-file=./envs/values.tfvars -target module.eradah_network -auto-approve
fi