variable "private_key_file_path_var" {
  default = "/home/vagrant/.ssh/devops106_rrajendran.pem"
}

variable "ubuntu_20_04_ami_id_var" {
  default = "ami-08ca3fed11864d6bb"
}

variable "public_key_name_var" {
  default = "devops106_rrajendran"
}

variable "region_var" {
  default = "eu-west-1"
}

locals {
  vpc_id_var = aws_vpc.devops106_terraform_rrajendran_vpc_tf.id
  route_table_id_var = aws_route_table.devops106_terraform_rrajendran_rt_public_tf.id
}
