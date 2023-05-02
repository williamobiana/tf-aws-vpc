# AWS x Terraform Module

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

## Overview
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_id"></a> [client_id](#input_client_id) | Client ID - use dsol for internal resources. Used in all name prefixes. | `string` | n/a | yes |
| <a name="input_deployment_id"></a> [deployment_id](#input_deployment_id) | The deployment/application ID to be used across stack resources. | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input_owner) | Technical owner of the resources. | `string` | n/a | yes |
| <a name="input_public_cidr_blocks"></a> [public_cidr_blocks](#input_public_cidr_blocks) | List of CIDR ranges that will be converted to public subnets. | `list(string)` | n/a | yes |
| <a name="input_create_default_routes"></a> [create_default_routes](#input_create_default_routes) | If `true` then default routes will be created for private subnet > NAT and public subnet > IGW. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input_environment) | Deployment environment, defaults to terraform.workspace. Used in all name prefixes. | `string` | `null` | no |
| <a name="input_private_cidr_blocks"></a> [private_cidr_blocks](#input_private_cidr_blocks) | List of CIDR ranges that will be converted to private subnets. Public egress provided by NAT Gateway in public subnet. | `list(string)` | `[]` | no |
| <a name="input_private_subnet_tags"></a> [private_subnet_tags](#input_private_subnet_tags) | Tags that will be assigned to the private subnets. Special tags are required for some AWS services such as Kubernetes. | `map(string)` | `{}` | no |
| <a name="input_public_subnet_tags"></a> [public_subnet_tags](#input_public_subnet_tags) | Tags that will be assigned to the public subnets. Special tags are required for some AWS services such as Kubernetes. | `map(string)` | `{}` | no |
| <a name="input_s3_flow_log_bucket_arn"></a> [s3_flow_log_bucket_arn](#input_s3_flow_log_bucket_arn) | ARN of S3 Bucket where VPC Flow Logs will be stored. If null will attempt to use default VPC Flow Logs bucket created by ACP. | `string` | `null` | no |
| <a name="input_vpc_cidr"></a> [vpc_cidr](#input_vpc_cidr) | CIDR of VPC that will be created for Elasticsearch hosting. | `string` | `null` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cidr_block"></a> [cidr_block](#output_cidr_block) | The CIDR Block for the VPC. |
| <a name="output_eip"></a> [eip](#output_eip) | Public IP of EIP assigned to NAT. |
| <a name="output_igw_id"></a> [igw_id](#output_igw_id) | ID of VPC Internet Gateway. |
| <a name="output_ngw_id"></a> [ngw_id](#output_ngw_id) | ID of VPC NAT Gateway. |
| <a name="output_private_rtb_id"></a> [private_rtb_id](#output_private_rtb_id) | ID of VPC private route table. |
| <a name="output_private_subnet_ids"></a> [private_subnet_ids](#output_private_subnet_ids) | IDs of VPC private subnets. |
| <a name="output_public_rtb_id"></a> [public_rtb_id](#output_public_rtb_id) | ID of VPC public route table. |
| <a name="output_public_subnet_ids"></a> [public_subnet_ids](#output_public_subnet_ids) | IDs of VPC public subnets. |
| <a name="output_s3_endpoint_id"></a> [s3_endpoint_id](#output_s3_endpoint_id) | ID of VPC S3 Endpoint. |
| <a name="output_security_group_id"></a> [security_group_id](#output_security_group_id) | ID of default VPC Security Group with 80/443 outbound. |
| <a name="output_vpc_id"></a> [vpc_id](#output_vpc_id) | ID of VPC. |
## Resources

| Name | Type |
|------|------|
| [aws_eip.eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_flow_log.flow_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.ngw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.ngw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_endpoint.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
## Modules

No modules.
## Usage

```hcl

```

## Documentation
We use a library called `terraform-docs` for automatically generating documentation for the variables, outputs, resources, and sub-modules defined within a Terraform module.   
The output from `terraform-docs` is wrapped between `HEADER.md` and `FOOTER.md` files which include custom module documentation and usage guidelines.

To ensure our documentation remains up-to-date, it is important that each time changes are made to a module the docs are updated by cd'ing into the module directory and running the following command:  

`terraform-docs --config docs/terraform-docs.yml markdown --escape=false . > README.md`
