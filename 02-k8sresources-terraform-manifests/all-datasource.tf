# Datasource: EKS Cluster 

data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

# Datasource: EKS Cluster Auth 
data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

data "terraform_remote_state" "vpc" {
  backend = "s3" # or other backend you are using
  config = {
    bucket = "terraform-on-aws-eks-bucket"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "terraform-on-aws-eks-bucket"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = "us-east-1"
  }
}