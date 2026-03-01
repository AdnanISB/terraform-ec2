#Outputs 
output "public_ip" {
  value = aws_instance.ec2[*].public_ip
}
output "public_dns" {
  value = aws_instance.ec2[*].public_dns  
}
output "public_key" {
  value = aws_key_pair.default.key_name  
}
output "username" {
value = var.ec2_username
}
