#!/usr/bin/env bash

set -e

echo "Building AMI with latest configuration..."
./script/build_ami.sh
echo "Updating Terraform infrastructure with new AMI..."
./script/apply_changes.sh
echo "Deploying code to newly built infrastructure..."
./script/deploy.sh
