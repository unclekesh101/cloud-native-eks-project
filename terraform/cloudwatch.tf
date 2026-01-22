# -----------------------------------
# Lookup ALB created by EKS Ingress
# -----------------------------------
data "aws_lb" "eks_alb" {
  tags = {
    "elbv2.k8s.aws/cluster" = module.eks.cluster_name
  }
}

# -----------------------------------
# CloudWatch Dashboard
# -----------------------------------
resource "aws_cloudwatch_dashboard" "eks" {
  dashboard_name = "cloud-native-eks-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/EKS", "cluster_failed_node_count", "ClusterName", module.eks.cluster_name],
            ["AWS/EKS", "cluster_node_count",        "ClusterName", module.eks.cluster_name]
          ]
          period = 300
          stat   = "Average"
          region = "us-east-1"
          title  = "EKS Node Health"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "RequestCount",             "LoadBalancer", data.aws_lb.eks_alb.arn_suffix],
            ["AWS/ApplicationELB", "HTTPCode_ELB_5XX_Count",   "LoadBalancer", data.aws_lb.eks_alb.arn_suffix]
          ]
          period = 60
          stat   = "Sum"
          region = "us-east-1"
          title  = "ALB Traffic & Errors"
        }
      }
    ]
  })
}
