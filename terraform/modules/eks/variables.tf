variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use for the EKS cluster"
  type        = string
}

variable "desired_size" {
  description = "The desired number of worker nodes in the EKS node group"
  type        = number
}

variable "max_size" {
  description = "The maximum number of worker nodes in the EKS node group"
  type        = number
}

variable "min_size" {
  description = "The minimum number of worker nodes in the EKS node group"
  type        = number
}

variable "max_unavailable" {
  description = "The maximum number of nodes that can be unavailable during an update"
  type        = number
}

variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster will be deployed"
  type        = string
}

variable "private_subnet_ids" {
  description = "The IDs of the private subnets where the EKS cluster will be deployed"
  type        = list(string)
}