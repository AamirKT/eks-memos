variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "memos-vpc"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/24"
}

variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.0.0/26", "10.0.0.64/26"]
}

variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.0.128/26", "10.0.0.192/26"]
}

variable "availability_zones" {
  description = "A list of availability zones to use for the subnets"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b"]
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-west-2"
}

variable "availability_mode" {
  description = "The availability mode for the NAT gateway (single or regional)"
  type        = string
  default     = "regional"
}

variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "memos-eks-cluster"
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use for the EKS cluster"
  type        = string
  default     = "1.35"
}

variable "desired_size" {
  description = "The desired number of worker nodes in the EKS node group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "The maximum number of worker nodes in the EKS node group"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "The minimum number of worker nodes in the EKS node group"
  type        = number
  default     = 1
}

variable "max_unavailable" {
  description = "The maximum number of nodes that can be unavailable during an update"
  type        = number
  default     = 1
}
