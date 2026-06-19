resource "aws_security_group" "eks_cluster_sg" {
  name        = "${var.cluster_name}-eks-cluster-sg"
  description = "Security group for EKS cluster"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_kubectl_ingress" {
  description       = "Allow kubectl access to the EKS cluster"
  security_group_id = aws_security_group.eks_cluster_sg.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "allow_cluster_to_nodegroup" {
  description                  = "Allow node group to communicate with the EKS cluster"
  security_group_id            = aws_security_group.eks_cluster_sg.id
  from_port                    = 443
  to_port                      = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.eks_nodegroup_sg.id
}

resource "aws_vpc_security_group_egress_rule" "allow_cluster_egress" {
  description       = "Allow all outbound traffic"
  security_group_id = aws_security_group.eks_cluster_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_security_group" "eks_nodegroup_sg" {
  name        = "${var.cluster_name}-eks-nodegroup-sg"
  description = "Security group for EKS node group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.cluster_name}-eks-nodegroup-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_nodegroup_ingress" {
  description                  = "Allow nodes to communicate with each other"
  security_group_id            = aws_security_group.eks_nodegroup_sg.id
  from_port                    = 0
  to_port                      = 65535
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.eks_nodegroup_sg.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_control_plane_ingress" {
  description                  = "Allow control plane to communicate with nodes"
  security_group_id            = aws_security_group.eks_nodegroup_sg.id
  from_port                    = 10250
  to_port                      = 10250
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.eks_cluster_sg.id
}

resource "aws_vpc_security_group_egress_rule" "allow_nodegroup_egress" {
  description       = "Allow all outbound traffic"
  security_group_id = aws_security_group.eks_nodegroup_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}