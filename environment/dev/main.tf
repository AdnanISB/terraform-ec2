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
module "frontend_ec2" {
  source         = "../../modules/ec2"
  environment    = var.environment
  ami            = var.ami
  instance_count = var.instance_count
  instance_type  = var.instance_type
  ec2_username   = var.ec2_username
  key_name       = aws_key_pair.default.key_name  # pass actual key name
  ec2_sg         = "frontend-${var.environment}"
  ssh_port       = var.ssh_port
  tags           = {
    Name = "Frontend-${var.environment}"
    Environment = "dev"
  }  # pass plain tags
  root_volume_size = 10
  root_volume_type = var.root_volume_type

  # Optional: pass provider if module defines its own
  providers = {
    aws = aws
  }
}

module "backend_ec2" {
  source         = "../../modules/ec2"
  environment    = var.environment
  ami            = var.ami
  instance_count = var.instance_count
  instance_type  = var.instance_type
  ec2_username   = var.ec2_username
  key_name       = aws_key_pair.default.key_name  # pass actual key name
  ec2_sg         = "backend-${var.environment}"
  ssh_port       = var.ssh_port
  tags           = {
    Name = "Backend-${var.environment}"
    Environment = "dev"
  }  # pass plain tags
  root_volume_size = var.root_volume_size
  root_volume_type = var.root_volume_type

  # Optional: pass provider if module defines its own
  providers = {
    aws = aws
  }
}

module "database_ec2" {
  source         = "../../modules/ec2"
  environment    = var.environment
  ami            = var.ami
  instance_count = 2
  instance_type  = var.instance_type
  ec2_username   = var.ec2_username
  key_name       = aws_key_pair.default.key_name  # pass actual key name
  ec2_sg         = "database-${var.environment}"
  ssh_port       = var.ssh_port
  tags           = {
    Name = "Database-${var.environment}"
    Environment = "dev"
  }  # pass plain tags
  root_volume_size = 20
  root_volume_type = var.root_volume_type

  # Optional: pass provider if module defines its own
  providers = {
    aws = aws
  }
}