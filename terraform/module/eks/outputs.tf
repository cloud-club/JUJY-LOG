output "eks_kubectl_role_name" {
    value = aws_iam_role.eks_kubectl_role.name
}