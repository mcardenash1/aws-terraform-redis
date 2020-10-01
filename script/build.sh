#!/bin/bash

echo "*** Deployment started"

echo -n "Enter the AWS_ACCESS_KEY_ID: "
read ACCESS_KEY

echo -n "Enter the AWS_SECRET_ACCESS_KEY: "
read SECRET_KEY

echo "Exported aws env"
export AWS_ACCESS_KEY_ID={$ACCESS_KEY}
export AWS_SECRET_ACCESS_KEY={$SECRET_KEY}

echo "***  starting terraform"
terraform plan && terraform apply

echo "*** Deployment complete"
