terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.6.6"
}

# To create the resources in the specified region
provider "aws" {
  region = var.aws_region
}

# To run the VPC module
module "vpc" {
  source                  = "./modules/vpc/"
  aws_region              = var.aws_region
  vpc_cidr_block          = var.vpc_cidr_block
  availability_zones      = var.availability_zones
  public_subnet_cidrs     = var.public_subnet_cidrs
  private_subnet_cidrs    =var.private_subnet_cidrs
}