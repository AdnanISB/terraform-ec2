environment = "dev"
ami = "ami-02dfbd4ff395f2a1b"
instance_count = 1
instance_type = "t2.micro"
ec2_username = "ec2-user"
key_name = "Terraform-dev-userdata"
ec2_sg = "allow_ssh_dev_1"
ssh_port = 80
tags = {
  "Name" = "Terraform-EC2"
  "Environment" = "dev"
       } 
root_volume_size = "15"
root_volume_type = "gp3"
# Load the bash script into user_data 
# user_data = "file('')" 


