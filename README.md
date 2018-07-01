# Rails Application Pipeline

A Continuous Delivery pipeline for Rails apps (WIP)

## Components

### Build

Uses: Packer, Ansible

Creates, saves and tags a new AMI:

- Installs RVM and ruby
- Installs JS runtime 
- Configures nginx/passenger
- Downloads application source
- Installs application dependancies 

### Deploy

uses: Terraform 

Provisions a given number of EC2 hosts using the newest AMI.

As well as this, provides the network infrastructure for the application to work (VPC, security groups, internet gateway etc.)

Uses Terraform remote state on S3. 

## Usage

The `script` directory provides an entry-point for common operations

## Demo

`script/end_to_end.sh` provides a usage demonstration.

