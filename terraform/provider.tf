terraform {
  required_version = "~> 1.15.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.50.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "3.2.0"
    }
  }

  backend "s3" {
    bucket       = "memos-aamir-s3"
    key          = "terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
    encrypt      = true
  }
}
provider "aws" {
  # Configuration options
  region = var.aws_region
}

data "aws_eks_cluster" "eks_cluster" {
  name = module.eks.eks_cluster_name
}

data "aws_eks_cluster_auth" "eks_cluster" {
  name = module.eks.eks_cluster_name
}

provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.eks_cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority[0].data)

    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", module.eks.eks_cluster_name]
    }
  }
}