output "alb_controller_role_arn" {
  description = "IAM role ARN used by AWS Load Balancer Controller (IRSA)"
  value       = aws_iam_role.alb_controller.arn
}

output "oidc_provider_arn" {
  description = "OIDC provider ARN for EKS IRSA"
  value       = aws_iam_openid_connect_provider.eks.arn
}
