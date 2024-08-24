# Terraform Remote State Datasource
/*
data "terraform_remote_state" "eks" {
  backend = "local"
  config = {
    path = "../../08-AWS-EKS-Cluster-Basics/01-ekscluster-terraform-manifests/terraform.tfstate"
   }
}
*/
# Terraform State Datasource Backend AWS S3 to get the Remote State Output from Project1
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "terraform-on-aws-eks-bucket"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = var.aws_region #"us-east-1"
  }
}

