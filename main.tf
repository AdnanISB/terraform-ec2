# Provider configuration 
provider "aws" { 
  region = "us-east-1"   # Change to your desired region 
} 
 
# Step 1 — Create SSH Key Pair 
resource "aws_key_pair" "default" { 
  key_name   = "terraform-key"           # Name of the key in AWS 
  public_key = file("~/.ssh/id_rsa.pub") # Path to your public key 
} 
 
# Step 2 — Create Security Group 
resource "aws_security_group" "ec2_sg" { 
  name        = "allow_ssh" 
  description = "Allow SSH inbound traffic" 
 
  ingress { 
    from_port   = 22 
    to_port     = 22 
    protocol    = "tcp" 
    cidr_blocks = ["0.0.0.0/0"] # Change to your IP for better security 
  } 
 
  egress { 
    from_port   = 0 
    to_port     = 0 
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"] 
  } 
}

resource "aws_instance" "ec2" {
  ami = "ami-0f3caa1cf4417e51b"
  instance_type = "t2.micro"
  key_name = aws_key_pair.default.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  tags = {
    name = "My-First-Terraform-Instance"
    }
}
#Outputs 
output "public_ip" {
  value = aws_instance.ec2.public_ip
}
output "public_key" {
  value = aws_key_pair.default.key_name
  
}
output "public_dns" {
  value = aws_instance.ec2.public_dns
  
}

