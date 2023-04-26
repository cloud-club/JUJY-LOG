resource "aws_iam_role" "eks_kubectl_role" {
  name = var.eks_kubectl_role_name
  description = "iam role for codebuild"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          "AWS": "arn:aws:iam::${var.aws_account_id}:root"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "eks_kubectl_policy" {
  name        = var.eks_kubectl_policy_name
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "eks:Describe*"
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "EKSKubectlRolePolicyAttachment" {
  policy_arn = aws_iam_policy.eks_kubectl_policy.arn
  role       = aws_iam_role.eks_kubectl_role.name
}
