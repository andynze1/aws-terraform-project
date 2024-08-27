
# HELM Provider
# For managing Helm Resources installing EBS CSI Drivers and other helm resources
provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
    cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.terraform_remote_state.eks.outputs.cluster_id]
      command     = "aws"
    }
  }

}



# provider "helm" {
#   kubernetes {
#     host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
#     cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
#     token                  = data.aws_eks_cluster_auth.cluster.token
#   }
# }