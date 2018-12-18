# Mission Control

Infrastructure management and deployment tool for Dockerized applications

### About

Mission Control is a set of integrated tools for tasks like:
  - Building AMis which are preconfigured for production docker use (with Packer)
  - Automating the creation of hosts with these AMIS (with Terraform)
  - Deploying applications to these hosts (with Ansible) 

### Planned

- Instant rollback
- Automated rolling deploys
- Server functionality

### Usage example

A demo application and infrastructure repo are provided.

Create required directories:
```
mkdir ~/src
mkdir ~/infra
```

Clone repos:
```
git clone https://github.com/looneym/mc-demo-app.git ~/src/mc-demo-app
git clone https://github.com/looneym/mc-demo-infra.git ~/infra/mc-demo-infra
```

The app is a Dockerized Rails app which is bundled with nginx Dockerfile. The two are run together with `docker-compose`
The infra is a VPC, some security groups and some EC2 hosts.

Build AMI:
```
mc ami
```

Run Terraform:
```
cd ~/infra/mc-demo-infra
terraform init
terraform apply
```

The hosts will automatically be provisioned with the AMI created earlier and Mission Control will populate
an ansible inventory file with the IPs of the machines.

Deploy:
```
mc deploy --app mc-demo-app -target emo_hosts -git_host github

```

Ansible will clone the repo, build the containers and run `docker-compose`

At this point the application should be up and running. 

To see it's public IP:

```
cd ~/infra/mc-demo-infra
terraform output
```

Paste the IP into your browser and you should see the welcome page.

You may also use Mission Control to ssh to the host:

```
mc ssh $ip
```

### Installation

clone the repo into your home directory and add the following to your path:

`export PATH=$PATH:~/mission-control/script`

This will add the `mc` executable to your path:

```
$ mc --help

Mission Control : infrastructure management and deployment tool

Usage:
  mc [command]
Available Commands:
  ami           build a new AMI
  deploy        deploy code to production
  ssh           ssh to a machine
```

### Requirements


#### Dependancies 

- Ansible
- Terraform 
- Packer

#### Directory Structure 

Mission Control ties together your applications source code and the infrastructure needed to run it. 
For this reason it depends on a specific directory structure:


```
── $HOME
   ├── infra
   │   └── my_app
   └── src
       └── my_app
```

#### AWS credentials

You will need to add a profile to ~/.aws/credentials

```
[mission-control]
aws_access_key_id=<>
aws_secret_access_key=<>
```

You will also need to create an SSH key pair on AWS called mission-control and place it in `~/.ssh/mission-control.pem`


