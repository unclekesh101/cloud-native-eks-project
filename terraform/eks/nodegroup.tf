resource "aws_launch_template" "eks_nodes" {
  name_prefix = "cloud-native-eks-nodes-"

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }
}
resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "cloud-native-nodes"
  node_role_arn   = var.node_role_arn

  subnet_ids = var.subnet_ids
    
  

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t3.micro"]
  capacity_type  = "ON_DEMAND"

  launch_template {
    id      = aws_launch_template.eks_nodes.id
    version = "$Latest"
  }
}
