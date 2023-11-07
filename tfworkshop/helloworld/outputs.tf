output "public_ip" {
    value = aws_instance.app_server[*].public_ip
}

output "instance_public_ip_by_module" {
  description = "Public IP address of the EC2 instance by module"
  value       = module.ec2_instance.instance_public_ip
}

