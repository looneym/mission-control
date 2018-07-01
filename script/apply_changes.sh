#!/usr/bin/env bash

set -e

export AWS_PROFILE=virus-aquarium-infra
cd deploy/main

terraform apply

