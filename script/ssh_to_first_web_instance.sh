#!/usr/bin/env bash

set -e

cd infra
first_web_instance_public_ip=$(terraform output --json  | jq .web_01_public_ips.value[0] | xargs)
ssh $first_web_instance_public_ip -l ubuntu -i ~/.ssh/virus_aquarium.pem

