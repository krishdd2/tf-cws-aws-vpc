terraform {
  backend "remote" {
    organization = "kk2-org"
    workspaces {
      name = "aws-vpc"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.60.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "aws" {
  region              = var.region  
}
