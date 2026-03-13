# create multiple instances with their username and count
variable "instance_count" {
  type = number
  description = "Number of ec2 instances" 
}

variable "ec2_username" {
  type = string
}

variable "key_name" {
    type = string
     
}

variable "ec2_sg" {
    type = string
    description = "Security group name" 
}

variable "ssh_port" {
    type = number
   
}

variable "ami" {
    type = string
  
}

variable "instance_type" {
    type = string
}

variable "tags" {
    type = map(string)

}

variable "root_volume_size" { 
  description = "Size of the EC2 root volume in GB" 
  type        = number 
} 
 
variable "root_volume_type" { 
  description = "Type of the EC2 root volume (gp2, gp3, io1, etc.)" 
  type        = string 
} 

variable "environment" {
  type = string
}