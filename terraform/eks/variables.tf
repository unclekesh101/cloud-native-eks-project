variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "cluster_role_arn" {
  type        = string
  description = "IAM role ARN for EKS control plane"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for EKS"
}
variable "node_role_arn" {
  type = string
  description = "Node group"
}
