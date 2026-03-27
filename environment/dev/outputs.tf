#Outputs 
/*output "public_ip" {
  value = aws_instance.ec2[*].public_ip
}*/

output "public_dns" {
  value = module.dev_ec2.public_dns  
}
/*output "ec2_instance_ids" {
  value = module.dev_ec2.instance_ids 
}*/
output "ec2_public_ips" {
  value = module.dev_ec2.public_ip  
}
/* output "instance_public_ip" {
  value = aws_instance.ec2[*].public_ip
}

output "instance_id" {
  value = aws_instance.ec2[*].id
}
 output "username" {
value = var.ec2_username
}*/
