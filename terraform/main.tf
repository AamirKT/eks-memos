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
  source                   = "./modules/eks"
  cluster_name             = var.eks_cluster_name
  kubernetes_version       = var.kubernetes_version
  desired_size             = var.desired_size
  max_size                 = var.max_size
  min_size                 = var.min_size
  max_unavailable          = var.max_unavailable
  vpc_id                   = module.vpc.vpc_id
  private_subnet_ids       = module.vpc.private_subnet_ids
  namespace                = var.eks_namespace
  service_account_name     = var.eks_service_account_name
  service_account_role_arn = module.eks.eks_service_account_role_arn
  rds_secret_arn           = module.rds.rds_secret_arn
  region                   = var.aws_region
  domain_name              = var.domain_name
  zone_id                  = var.zone_id
  memos_access_policy_arn  = var.memos_access_policy_arn
  memos_secret_arn         = module.rds.rds_secret_arn
}

module "sg" {
  source                    = "./modules/sg"
  cluster_name              = var.eks_cluster_name
  vpc_id                    = module.vpc.vpc_id
  eks_cluster_default_sg_id = module.eks.eks_cluster_sg_id
}

module "rds" {
  source                 = "./modules/rds"
  db_instance_identifier = var.db_instance_identifier
  db_engine              = var.db_engine
  db_engine_version      = var.db_engine_version
  db_instance_class      = var.db_instance_class
  db_allocated_storage   = var.db_allocated_storage
  db_name                = var.db_name
  db_username            = var.db_username
  vpc_private_subnet_ids = module.vpc.private_subnet_ids
  db_multi_az            = var.db_multi_az
  skip_final_snapshot    = var.skip_final_snapshot
  rds_sg_id              = [module.sg.aws_security_group_rds_sg_id]
}
