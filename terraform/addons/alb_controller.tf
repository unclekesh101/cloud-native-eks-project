locals {
  oidc_host = replace(
    aws_iam_openid_connect_provider.eks.url,
    "https://",
    ""
  )
}

# Placeholder – actual Helm install later
# This ensures Terraform wiring is correct
