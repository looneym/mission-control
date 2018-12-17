variable "shared_credentials_file" {
  default = "~/.aws/credentials"
}

variable "region" {
  default = "us-east-1"
}

variable "key_pair_name" {
  default = "virus-aquarium-infra"
}

variable "ssh_key_name" {
  default = "virus_aquarium"
}

variable "web_01_hosts_count" {}
variable "web_02_hosts_count" {}
