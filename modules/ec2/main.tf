# Step 1 — Create Security Group
resource "aws_security_group" "ec2_sg" {
  name        = var.ec2_sg
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # For production restrict to your IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Step 2 — Create EC2 instance
resource "aws_instance" "ec2" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type

  key_name = var.key_name

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name        = "${var.tags["Name"]}-${count.index + 1}"
    Environment = var.environment
  }

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
  }
}