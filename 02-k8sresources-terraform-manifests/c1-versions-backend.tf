# Terraform Settings Block
terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = ">= 4.65"
      version = ">= 5.31"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      #version = "~> 2.7"
      version = ">= 2.20"
    }
    http = {
      source = "hashicorp/http"
      #version = "2.1.0"
      #version = "~> 2.1"
      version = "~> 3.3"
    }
    helm = {
      source = "hashicorp/helm"
      #version = "2.4.1"
      #version = "~> 2.4"
      #version = "~> 2.9"
      version = "2.15.0"
    }
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "terraform-on-aws-eks-bucket"
    key    = "dev/app1k8s/terraform.tfstate"
    region = "us-east-1" #var.aws_region

    # For State Locking
    dynamodb_table = "dev-aws-lbc-ingress"
  }
}

# Terraform HTTP Provider Block
provider "http" {
  # Configuration options
}