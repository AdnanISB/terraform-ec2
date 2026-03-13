# Generate an RSA private key
resource "tls_private_key" "generated" { 
  algorithm = "RSA" 
  rsa_bits  = 4096 
}

# Random suffix for key name to prevent duplicates
resource "random_id" "suffix" {
  byte_length = 2
}

# AWS Key Pair
resource "aws_key_pair" "default" {
  key_name   = "${var.key_name}-${random_id.suffix.hex}"  # unique key
  public_key = tls_private_key.generated.public_key_openssh
}

# Save private key locally
resource "local_file" "private_key" {  
  content         = tls_private_key.generated.private_key_pem  
  filename        = "private_key_${var.environment}.pem"  
  file_permission = "0400"
} 

# Call EC2 module (without count.index)
module "dev_ec2" {
  source         = "../../modules/ec2"
  environment    = var.environment
  ami            = var.ami
  instance_count = var.instance_count
  instance_type  = var.instance_type
  ec2_username   = var.ec2_username
  key_name       = aws_key_pair.default.key_name  # pass actual key name
  ec2_sg         = var.ec2_sg
  ssh_port       = var.ssh_port
  tags           = var.tags  # pass plain tags
  root_volume_size = var.root_volume_size
  root_volume_type = var.root_volume_type

  # Optional: pass provider if module defines its own
  providers = {
    aws = aws
  }
}