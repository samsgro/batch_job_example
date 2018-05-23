#!/bin/bash

echo "deploying global insfrastructure"

cd infrastructure/dev/global
terraform init

if [ "$?" -ne 0]; then
   exit 1
fi

terraform plan -out terraformplan.out

if [ "$?" -ne 0]; then
   exit 1
fi

terraform apply terraformplan.out

if [ "$?" -ne 0]; then
   exit 1
fi

rm -rf terraformplan.out

echo "Consumatum est..."
