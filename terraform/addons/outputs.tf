output "oidc_provider_arn" {
  description = "OIDC provider ARN for EKS IRSA"
  value       = aws_iam_openid_connect_provider.eks.arn
}
