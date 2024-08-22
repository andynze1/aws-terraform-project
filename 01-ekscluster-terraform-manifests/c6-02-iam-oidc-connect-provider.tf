# Datasource: AWS Partition
# Use this data source to lookup information about the current AWS partition in which Terraform is working
data "aws_partition" "current" {}



data "aws_eks_cluster" "eks_cluster" {
  name = local.eks_cluster_name
  depends_on = [ aws_eks_cluster.eks_cluster ]
}

data "aws_eks_cluster_auth" "eks_cluster_auth" {
  name = local.eks_cluster_name
  depends_on = [ aws_eks_cluster.eks_cluster ]
}

data "external" "oidc_thumbprint" {
  program = ["bash", "${path.module}/get_thumbprint.sh"]
}

# # Resource: AWS IAM Open ID Connect Provider
 resource "aws_iam_openid_connect_provider" "oidc_provider" {
  url             = data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
  client_id_list  = ["sts.${data.aws_partition.current.dns_suffix}"]# ["sts.amazonaws.com"]
  thumbprint_list = [data.external.oidc_thumbprint.result.thumbprint]
  # thumbprint_list = ["9451AD2B53C7F41FAB22886CC07D482085336561"]
  tags = merge(
    {
      Name = "${var.cluster_name}-eks-irsa"
    },
    local.common_tags
  )
}

# Output: AWS IAM Open ID Connect Provider ARN
output "aws_iam_openid_connect_provider_arn" {
  description = "AWS IAM Open ID Connect Provider ARN"
  value = aws_iam_openid_connect_provider.oidc_provider.arn 
}

# Extract OIDC Provider from OIDC Provider ARN
locals {
    aws_iam_oidc_connect_provider_extract_from_arn = element(split("oidc-provider/", "${aws_iam_openid_connect_provider.oidc_provider.arn}"), 1)
}

# Output: AWS IAM Open ID Connect Provider
output "aws_iam_openid_connect_provider_extract_from_arn" {
  description = "AWS IAM Open ID Connect Provider extract from ARN"
   value = local.aws_iam_oidc_connect_provider_extract_from_arn
}

# Sample Outputs for Reference
/*
aws_iam_openid_connect_provider_arn = "arn:aws:iam::180789647333:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/A9DED4A4FA341C2A5D985A260650F232"
aws_iam_openid_connect_provider_extract_from_arn = "oidc.eks.us-east-1.amazonaws.com/id/A9DED4A4FA341C2A5D985A260650F232"
*/