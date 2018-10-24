provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

# lab 1
module "vpc" {
  source           = "github.com/timarenz/tf_aws_vpc"
  environment_name = "${var.environment}"
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "vpc_name" {
  value = "${module.vpc.vpc_name}"
}

output "private_subnet_name" {
  value = "${module.vpc.vpc_private_subnet_name}"
}

output "private_subnet_az" {
  value = "${module.vpc.vpc_private_subnet_az}"
}

output "public_subnet_name" {
  value = "${module.vpc.vpc_public_subnet_name}"
}

output "public_subnet_az" {
  value = "${module.vpc.vpc_public_subnet_az}"
}

module "avicontroller" {
  source = "github.com/timarenz/tf-aws-avicontroller"

  public_key = "${file("lab.key.pub")}"

  #ami_id            = "ami-20de614f" #17.1.9
  #ami_id            = "ami-0463e66b" #17.2.3
  # ami_id = "ami-0566086a" #17.2.7

  subnet_id        = "${module.vpc.vpc_public_subnet_id}"
  password         = "${var.password}"
  environment_name = "${var.environment}"
}

output "avicontroller_public_ip" {
  value = "${module.avicontroller.public_ip}"
}

module "perf_server_client" {
  source            = "github.com/timarenz/tf_aws_perf_server_client"
  public_subnet_id  = "${module.vpc.vpc_public_subnet_id}"
  private_subnet_id = "${module.vpc.vpc_private_subnet_id}"
  environment_name  = "${var.environment}"
}

output "client_public_ip" {
  value = "${module.perf_server_client.client_public_ip}"
}

resource "null_resource" "avi_cloud" {
  depends_on = ["module.avicontroller"]

  provisioner "local-exec" {
    command = "ansible-playbook files/configure-cloud.yml --extra-vars 'avi_controller=${module.avicontroller.public_ip[0]} avi_username=admin avi_password=${var.password} vpc_name=${module.vpc.vpc_name} vpc_id=${module.vpc.vpc_id} private_subnet_az=${module.vpc.vpc_private_subnet_az} private_subnet_name=${module.vpc.vpc_private_subnet_name}'"
  }
}
