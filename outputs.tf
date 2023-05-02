
output "cidr_block" {
  description = "The CIDR Block for the VPC."
  value       = aws_vpc.vpc.cidr_block
}

output "eip" {
  description = "Public IP of EIP assigned to NAT."
  value       = aws_eip.eip.public_ip
}

output "igw_id" {
  description = "ID of VPC Internet Gateway."
  value       = aws_internet_gateway.igw.id
}

output "ngw_id" {
  description = "ID of VPC NAT Gateway."
  value       = aws_nat_gateway.ngw.id
}

output "private_rtb_id" {
  description = "ID of VPC private route table."
  value       = aws_route_table.private.id
}

output "private_subnet_ids" {
  description = "IDs of VPC private subnets."
  value       = aws_subnet.private[*].id
}

output "public_rtb_id" {
  description = "ID of VPC public route table."
  value       = aws_route_table.public.id
}

output "public_subnet_ids" {
  description = "IDs of VPC public subnets."
  value       = aws_subnet.public[*].id
}

output "s3_endpoint_id" {
  description = "ID of VPC S3 Endpoint."
  value       = aws_vpc_endpoint.s3.id
}

output "security_group_id" {
  description = "ID of default VPC Security Group with 80/443 outbound."
  value       = aws_security_group.default.id
}

output "vpc_id" {
  description = "ID of VPC."
  value       = aws_vpc.vpc.id
}