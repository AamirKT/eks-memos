output "aws_security_group_eks_cluster_sg_id" {
  description = "The ID of the EKS cluster security group"
  value       = aws_security_group.eks_cluster_sg.id
}

output "aws_security_group_eks_nodegroup_sg_id" {
  description = "The ID of the EKS node group security group"
  value       = aws_security_group.eks_nodegroup_sg.id
}
