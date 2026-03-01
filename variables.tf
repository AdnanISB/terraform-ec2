# create multiple instances with their username and count
variable "instance_count" {
  type = number
  default = 2
  description = "Number of ec2 instances" 
}

variable "ec2_username" {
  type = string
  default = "ec2-user"
}

variable "key_name" {
    type = string
    default = "terraform-third-key"
  
}

variable "ec2_sg" {
    type = string
    default = "allow ssh"
    description = "Security group name" 
}

variable "ssh_port" {
    type = number
    default = 22
}

variable "ami" {
    type = string
    default = "ami-0f3caa1cf4417e51b"
  
}

variable "instance_type" {
    type = string
    default = "t2.micro" 
}

variable "tags" {
    type = map(string)
    default = {
      "Name" = "Terraform-EC2"
    }
}

variable "root_volume_size" { 
  description = "Size of the EC2 root volume in GB" 
  type        = number 
  default     = 20 
} 
 
variable "root_volume_type" { 
  description = "Type of the EC2 root volume (gp2, gp3, io1, etc.)" 
  type        = string 
  default     = "gp3" 
} 