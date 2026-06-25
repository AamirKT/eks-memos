resource "aws_security_group" "rds_sg" {
  name        = "${var.cluster_name}-rds-sg"
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.cluster_name}-rds-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_eks_to_rds" {
  description                  = "Allow EKS cluster to communicate with RDS instance"
  security_group_id            = aws_security_group.rds_sg.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
  referenced_security_group_id = var.eks_cluster_default_sg_id
}

resource "aws_vpc_security_group_egress_rule" "allow_rds_egress" {
  description       = "Allow all outbound traffic"
  security_group_id = aws_security_group.rds_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
