#!/usr/bin/env bash

set -e

cd deploy/main
testbench_ip=$(terraform output --json  | jq .testbench_public_ip.value[0] | xargs)
ssh $testbench_ip -l ubuntu -i ~/.ssh/virus_aquarium.pem

