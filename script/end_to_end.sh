#!/usr/bin/env bash

set -e

echo "Building AMI with latest configuration and source code..."
# ./script/build_ami.sh
echo "Updating Terraform infrastructure with new AMI..."
# ./script/apply_changes.sh

cd terraform/main
ip=$(terraform output --json  | jq .web_instance_public_ips.value[0] | xargs)

echo "Attempting to reach the web_app"

echo "Attempt 1"
curl $ip
echo 

sleep 30
echo "Attempt 2"
curl $ip
echo 

sleep 30
echo "Attempt 3"
curl $ip
echo 
