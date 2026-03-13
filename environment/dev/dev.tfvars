environment = "dev"
ami = "ami-0b6c6ebed2801a5cb"
instance_count = 1
instance_type = "t2.micro"
ec2_username = "ubuntu"
key_name = "Terraform-dev-first"
ec2_sg = "allow_ssh_dev"
ssh_port = "22"
tags = {
  "Name" = "Terraform-EC2"
  "Environment" = "dev"
       } 
root_volume_size = "15"
root_volume_type = "gp3"



