
locals {
  prefix      = "${local.environment}-${var.client_id}"
  environment = var.environment == null ? terraform.workspace : var.environment
  default_tags = {
    client        = var.client_id
    deployment_id = var.deployment_id
    environment   = local.environment
    owner         = var.owner
  }
}

data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}