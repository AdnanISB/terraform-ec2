# Step 1 — Create SSH Key Pair 
resource "aws_key_pair" "default" { 
  key_name   = var.key_name         # Name of the key in AWS 
  public_key = file("~/.ssh/id_rsa.pub") # Path to your public key 
} 
 
# Step 2 — Create Security Group 
resource "aws_security_group" "ec2_sg" { 
  name        = var.ec2_sg
  description = "Allow SSH inbound traffic" 
 
  ingress { 
    from_port   = var.ssh_port 
    to_port     = var.ssh_port
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

# Create EC2 instance
resource "aws_instance" "ec2" {
  ami = var.ami  # Amazon Linux
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  count = var.instance_count
  tags = {
     Name = "${lookup(var.tags, "Name", "EC2")}-${count.index + 1}" 
  }
  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
  }
}

