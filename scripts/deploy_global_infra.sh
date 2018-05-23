#!/bin/bash

echo "deploying global insfrastructure"

cd infrastructure/dev/global
terraform init
echo $?
terraform plan -out terraformplan.out
terraform apply terraformplan.out
rm -rf terraformplan.out

echo "Consumatum est..."
