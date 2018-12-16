#!/usr/bin/env bash

ansible-playbook --inventory-file=infra/ansible_inventory --inventory-file=deploy/config.yml deploy/playbook.yml
