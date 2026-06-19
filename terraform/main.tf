module "vpc" {
  source               = "./modules/vpc"
  vpc_name             = var.vpc_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  aws_region           = var.aws_region
  availability_mode    = var.availability_mode
}

module "eks" {
  source             = "./modules/eks"
  cluster_name       = var.eks_cluster_name
  kubernetes_version = var.kubernetes_version
  desired_size       = var.desired_size
  max_size           = var.max_size
  min_size           = var.min_size
  max_unavailable    = var.max_unavailable
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "sg" {
  source       = "./modules/sg"
  cluster_name = var.eks_cluster_name
  vpc_id       = module.vpc.vpc_id
}