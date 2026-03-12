resource "aws_eks_access_entry" "jump_server" {
  cluster_name  = aws_eks_cluster.eks[0].name
  principal_arn = "arn:aws:iam::161807613169:role/fearwomen"

  type = "STANDARD"
}

resource "aws_eks_access_policy_association" "jump_server_admin" {
  cluster_name  = aws_eks_cluster.eks[0].name
  principal_arn = aws_eks_access_entry.jump_server.principal_arn

  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}
