
variable "client_id" {
  description = "Client ID - use dsol for internal resources. Used in all name prefixes."
  type        = string
}

variable "deployment_id" {
  description = "The deployment/application ID to be used across stack resources."
  type        = string
}

variable "environment" {
  type        = string
  description = "Deployment environment, defaults to terraform.workspace. Used in all name prefixes."
  default     = null
}

variable "owner" {
  description = "Technical owner of the resources."
  type        = string
}


variable "create_default_routes" {
  description = "If `true` then default routes will be created for private subnet > NAT and public subnet > IGW."
  default     = true
  type        = bool
}

variable "private_cidr_blocks" {
  description = "List of CIDR ranges that will be converted to private subnets. Public egress provided by NAT Gateway in public subnet."
  type        = list(string)
  default     = []
}

variable "public_cidr_blocks" {
  description = "List of CIDR ranges that will be converted to public subnets."
  type        = list(string)

  validation {
    condition     = length(var.public_cidr_blocks) > 0
    error_message = "At least one public CIDR block must be provided."
  }
}

variable "s3_flow_log_bucket_arn" {
  description = "ARN of S3 Bucket where VPC Flow Logs will be stored. If null will attempt to use default VPC Flow Logs bucket created by ACP."
  type        = string
  default     = null
}

variable "vpc_cidr" {
  description = "CIDR of VPC that will be created for Elasticsearch hosting."
  type        = string
  default     = null
}

variable "public_subnet_tags" {
  description = "Tags that will be assigned to the public subnets. Special tags are required for some AWS services such as Kubernetes."
  default     = {}
  type        = map(string)
}

variable "private_subnet_tags" {
  description = "Tags that will be assigned to the private subnets. Special tags are required for some AWS services such as Kubernetes."
  default     = {}
  type        = map(string)
}
