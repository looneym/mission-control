#!/usr/bin/env bash

set -e

export AWS_PROFILE=virus-aquarium-infra
cd packer

packer build \
  templates/virus_aquarium_web.json