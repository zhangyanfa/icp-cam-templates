provider "aws" {
 region = "${var.aws_region}"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-west-2"
}

variable "subnet_id" {
  description = "Subnet Id"
  default = "subnet-1943137c"
}

variable "public_ssh_key_name" {
  description = "Name of the public SSH key used to connect to the virtual guest"
  default = "icp-cam-key"
}

variable "aws_amis" {
  default = {
    us-west-2 = "ami-f4533694"
  }
}

variable "bootstrap_icp_ee_singlenode_file" {
    description = "The path to the script to bootstrap the ICP master node."
    default = "bootstrap_icp_ee_singlenode.sh"
}

resource "aws_instance" "icp_singlenode" {
    instance_type = "t2.xlarge"
    ami = "${lookup(var.aws_amis, var.aws_region)}"
    subnet_id = "${var.subnet_id}"
    vpc_security_group_ids = ["sg-4555e839"]
    key_name = "${var.public_ssh_key_name}"

    associate_public_ip_address = true

    root_block_device {
        volume_type = "standard"
        volume_size = 150
    }

}