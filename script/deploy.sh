#!/usr/bin/env bash

ansible-playbook --inventory-file=infra/ansible_inventory.cfg --inventory-file=deploy/config.yml deploy/playbook.yml
