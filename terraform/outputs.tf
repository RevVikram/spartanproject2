output "webservers_ip_addresses_output"{
  value = aws_instance.devops106_terraform_rrajendran_webserver_tf[*].public_ip
}
