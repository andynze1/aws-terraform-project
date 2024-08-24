resource "aws_security_group_rule" "allow_port_31280" {
  type              = "ingress"
  from_port         = 31280
  to_port           = 31280
  protocol          = "tcp"
  security_group_id = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id
  cidr_blocks       = ["0.0.0.0/0"]  # or your specific CIDR
}

# Create AWS EKS Node Group - Public
resource "aws_eks_node_group" "eks_ng_public" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${local.name}-eks-ng-public"
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = module.vpc.public_subnets
  ami_type        = "AL2_x86_64"
  capacity_type   = "ON_DEMAND"
  disk_size       = 25
  instance_types  = ["t3.medium"]
  remote_access {
    ec2_ssh_key               = "eks-terraform-key"
    source_security_group_ids = [aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id]
  }
  scaling_config {
    desired_size = 2
    min_size     = 2
    max_size     = 3
  }
  update_config {
    max_unavailable = 1
  }
  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.ec2_registry_readonly,
    kubernetes_config_map_v1.aws_auth
  ]
  tags = {
    Name = "Public-Node-Group"
  }
}

################################################################
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "terraform-on-aws-eks-bucket" 
    key    = "dev/eks-cluster/terraform.tfstate" 
    region = "us-east-1"
  }
}


# # Terraform Kubernetes Provider
# provider "kubernetes" {
#   host = data.terraform_remote_state.eks.outputs.cluster_endpoint 
#   cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
#   token = data.aws_eks_cluster_auth.cluster.token
# }
