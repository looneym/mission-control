#!/usr/bin/env bash

set -e

export AWS_PROFILE=virus-aquarium-infra
cd ami/docker

packer build \
  docker.json
