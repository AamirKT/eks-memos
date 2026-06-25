variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster will be deployed"
  type        = string
}

variable "eks_cluster_default_sg_id" {
  description = "The ID of the default security group for the EKS cluster"
  type        = string
}