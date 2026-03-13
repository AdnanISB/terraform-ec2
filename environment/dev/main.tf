# Step 1 — Create SSH Key Pair 

# Call EC2 module
module "dev_ec2" {
  source = "../../modules/ec2"
  environment = var.environment
  ami = var.ami
  count = var.instance_count
  instance_type  = var.instance_type
  ec2_username = var.ec2_username
  key_name = var.key_name
  ec2_sg = var.ec2_sg
  ssh_port = var.ssh_port
  tags = {
    Name = "${var.tags["Name"]}-${count.index+1}"
    Environment = var.environment 
  }
  root_volume_size = var.root_volume_size
  root_volume_type = var.root_volume_type
}