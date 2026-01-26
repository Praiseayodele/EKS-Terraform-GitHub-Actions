resource "aws_eks_access_entry" "jump_server" {
  cluster_name = aws_eks_cluster.eks[0].name
  principal_arn = "arn:aws:iam::163205449102:role/Mernstackproject"

  type = "STANDARD"
}
