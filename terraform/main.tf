provider "aws" {
  region = var.region_var
}

resource "aws_vpc" "devops106_terraform_rrajendran_vpc_tf" {
  cidr_block = "10.210.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "devops106_terraform_rrajendran_vpc"
  }
}

resource "aws_subnet" "devops106_terraform_rrajendran_subnet_webserver_tf" {
  vpc_id = local.vpc_id_var
  cidr_block = "10.210.1.0/24"

  tags = {
    Name = "devops106_terraform_rrajendran_subnet_webserver"
  }
}

resource "aws_subnet" "devops106_terraform_rrajendran_subnet_db_tf" {
  vpc_id = local.vpc_id_var
  cidr_block = "10.210.2.0/24"

  tags = {
    Name = "devops106_terraform_rrajendran_subnet_db"
  }
}

resource "aws_internet_gateway" "devops106_terraform_rrajendran_igw_tf" {
  vpc_id = local.vpc_id_var

  tags = {
    Name = "devops106_terraform_rrajendran_igw"
  }
}

resource "aws_route_table" "devops106_terraform_rrajendran_rt_public_tf" {
  vpc_id = local.vpc_id_var

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops106_terraform_rrajendran_igw_tf.id
  }

  tags = {
    Name = "devops106_terraform_rrajendran_rt_public"
  }
}

resource "aws_route_table_association" "devops106_terraform_rrajendran_rt_assoc_public_webserver_tf" {
    subnet_id = aws_subnet.devops106_terraform_rrajendran_subnet_webserver_tf.id
    route_table_id = local.route_table_id_var
}

resource "aws_route_table_association" "devops106_terraform_rrajendran_rt_assoc_public_db_tf" {
    subnet_id = aws_subnet.devops106_terraform_rrajendran_subnet_db_tf.id
    route_table_id = local.route_table_id_var
}

resource "aws_network_acl" "devops106_terraform_rrajendran_nacl_public_tf" {
  vpc_id = local.vpc_id_var

  ingress {
    rule_no = 100
    from_port = 22
    to_port = 22
    cidr_block = "0.0.0.0/0"
    protocol = "tcp"
    action = "allow"
  }

  ingress {
    rule_no = 200
    from_port = 8080
    to_port = 8080
    cidr_block = "0.0.0.0/0"
    protocol = "tcp"
    action = "allow"
  }

  ingress {
    rule_no = 10000
    from_port = 1024
    to_port = 65535
    cidr_block = "0.0.0.0/0"
    protocol = "tcp"
    action = "allow"
  }


  egress {
    rule_no = 100
    from_port = 80
    to_port = 80
    cidr_block = "0.0.0.0/0"
    protocol = "tcp"
    action = "allow"
  }

  egress {
    rule_no = 200
    from_port = 443
    to_port = 443
    cidr_block = "0.0.0.0/0"
    protocol = "tcp"
    action = "allow"
  }

  egress {
    rule_no = 10000
    from_port = 1024
    to_port = 65535
    cidr_block = "0.0.0.0/0"
    protocol = "tcp"
    action = "allow"
  }

  subnet_ids = [aws_subnet.devops106_terraform_rrajendran_subnet_webserver_tf.id]

  tags = {
    Name = "devops106_terraform_rrajendran_nacl_public"
  }
}

resource "aws_network_acl" "devops106_terraform_rrajendran_nacl_db_tf" {
  vpc_id = local.vpc_id_var

  ingress {
    rule_no = 100
    from_port = 22
    to_port = 22
    cidr_block = "0.0.0.0/0"
    protocol = "tcp"
    action = "allow"
  }

  ingress {
    rule_no = 200
    from_port = 27017
    to_port = 27017
    cidr_block = "0.0.0.0/0"
    protocol = "tcp"
    action = "allow"
  }

  ingress {
    rule_no = 10000
    from_port = 1024
    to_port = 65535
    cidr_block = "0.0.0.0/0"
    protocol = "tcp"
    action = "allow"
  }


  egress {
    rule_no = 100
    from_port = 80
    to_port = 80
    cidr_block = "0.0.0.0/0"
    protocol = "tcp"
    action = "allow"
  }

  egress {
    rule_no = 200
    from_port = 443
    to_port = 443
    cidr_block = "0.0.0.0/0"
    protocol = "tcp"
    action = "allow"
  }

  egress {
    rule_no = 10000
    from_port = 1024
    to_port = 65535
    cidr_block = "0.0.0.0/0"
    protocol = "tcp"
    action = "allow"
  }

  subnet_ids = [aws_subnet.devops106_terraform_rrajendran_subnet_db_tf.id]

  tags = {
    Name = "devops106_terraform_rrajendran_nacl_db"
  }
}

resource "aws_security_group" "devops106_terraform_rrajendran_sg_webserver_tf" {
    name = "devops106_terraform_rrajendran_sg_webserver"
    vpc_id = local.vpc_id_var

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      from_port = 0
      to_port = 0
      protocol = -1
      cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "devops106_terraform_rrajendran_sg_webserver"
    }
}

resource "aws_security_group" "devops106_terraform_rrajendran_sg_db_tf" {
    name = "devops106_terraform_rrajendran_sg_db"
    vpc_id = local.vpc_id_var

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      from_port = 27017
      to_port = 27017
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      from_port = 0
      to_port = 0
      protocol = -1
      cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "devops106_terraform_rrajendran_sg_db"
    }
}
data "template_file" "app_init" {
  template = file("../init-scripts/docker-install.sh")
}
/*
data "template_file" "app_run" {
  template = file("../init-scripts/docker-run.sh")
}
*/
resource "aws_instance" "devops106_terraform_rrajendran_webserver_tf" {
  ami = var.ubuntu_20_04_ami_id_var
  instance_type = "t2.micro"
  key_name = var.public_key_name_var
  vpc_security_group_ids = [aws_security_group.devops106_terraform_rrajendran_sg_webserver_tf.id]

  subnet_id = aws_subnet.devops106_terraform_rrajendran_subnet_webserver_tf.id
  associate_public_ip_address = true

  count = 2
  user_data = data.template_file.app_init.rendered
# user_data = join("\n", [data.template_file.app_init.rendered, data.template_file.app_run.rendered])
#  user_data = [
#    "data.template_file.app_init.rendered",
#    "data.template_file.app_run.rendered"
#  ]
#user_data = data.template_file.app_init.rendered
#  user_data = data.template_file.app_run.rendered


  tags = {
    Name = "devops106_terraform_rrajendran_webserver_${count.index}"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    host = self.public_ip
    private_key = file(var.private_key_file_path_var)
  }

/*
  provisioner "file" {
    source = "../init-scripts/docker-install.sh"
    destination = "/home/ubuntu/docker-install.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "bash /home/ubuntu/docker-install.sh"
    ]
  }
  */

/*
  provisioner "local-exec" {
  command = "echo mongodb://${aws_instance.devops106_terraform_rrajendran_db_tf.public_ip}:27017 > ../database.config"
  }

  provisioner "file" {
    source = "../database.config"
    destination = "/home/ubuntu/database.config"
  }

  provisioner "remote-exec" {
    inline = [
      "docker run -d hello-world",
      "ls -la /home/ubuntu",
      "cat /home/ubuntu/database.config",
      "docker run -d -p 8080:8080 -v /home/ubuntu/log:/log -v /home/ubuntu/database.config:/database.config revvikram/spartanpy:0.5"
    ]
  }
*/
}
data "template_file" "db_init" {
  template = file("../init-scripts/mongodb-install.sh")
}
resource "aws_instance" "devops106_terraform_rrajendran_db_tf" {
  ami = var.ubuntu_20_04_ami_id_var
  instance_type = "t2.micro"
  key_name = var.public_key_name_var
  vpc_security_group_ids = [aws_security_group.devops106_terraform_rrajendran_sg_db_tf.id]

  subnet_id = aws_subnet.devops106_terraform_rrajendran_subnet_db_tf.id
  associate_public_ip_address = true
  user_data = data.template_file.db_init.rendered
  tags = {
    Name = "devops106_terraform_rrajendran_db"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    host = self.public_ip
    private_key = file(var.private_key_file_path_var)
  }

  /*provisioner "file" {
    source = "../init-scripts/mongodb-install.sh"
    destination = "/home/ubuntu/mongodb-install.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "bash /home/ubuntu/mongodb-install.sh"
    ]

  }*/
}
resource "aws_route53_zone" "devops106_terraform_rrajendran_dns_zone_tf" {
  name ="rrajendran.devops106"

  vpc{
    vpc_id = local.vpc_id_var
  }

}
resource "aws_route53_record" "devops106_terraform_rrajendran_dns_db_tf"{
  zone_id =aws_route53_zone.devops106_terraform_rrajendran_dns_zone_tf.zone_id
  name = "db"
  type = "A"
  ttl = "30"
  records = [aws_instance.devops106_terraform_rrajendran_db_tf.public_ip]

}
