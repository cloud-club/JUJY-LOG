#role
resource "aws_iam_role" "codebuild_role" {
  name = var.codebuild_role_name

  assume_role_policy = jsonencode({
    Version: "2012-10-17",
    Statement: [
        {
            Effect: "Allow",
            Principal: {
                Service: "codebuild.amazonaws.com"
            },
            Action: "sts:AssumeRole"
        }
    ]
  })
}

#policy
resource "aws_iam_policy" "codebuild_assume_role_policy" {
  name        = var.codebuild_assume_role_policy_name
  description = "Allows assuming tf-EksCodeBuildKubectlRole"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "VisualEditor0"
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Resource = "arn:aws:iam::${var.aws_account_id}:role/${var.eks_kubectl_role_name}"
      }
    ]
  })
}

data "aws_iam_policy_document" "codebuild_base_policy_document" {
  statement {
    sid       = "VisualEditor0"
    actions   = ["logs:*", "s3:*", "codebuild:*", "iam:*"]
    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "codebuild_base_policy" {
  name        = var.codebuild_base_policy_name
  path        = "/"
  description = "Codebuild policy"
  policy      = data.aws_iam_policy_document.codebuild_base_policy_document.json
}

#attachment
resource "aws_iam_role_policy_attachment" "codebuild_base_policy_attachment" {
  policy_arn = aws_iam_policy.codebuild_base_policy.arn
  role       = aws_iam_role.codebuild_role.id
}

resource "aws_iam_role_policy_attachment" "codebuild_assume_role_policy" {
    policy_arn = aws_iam_policy.codebuild_assume_role_policy.arn
    role = aws_iam_role.codebuild_role.name
}

resource "aws_iam_role_policy_attachment" "codebuild_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.codebuild_role.name
}

resource "aws_iam_role_policy_attachment" "codebuild_ecr_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  role = aws_iam_role.codebuild_role.name
}

resource "aws_iam_role_policy_attachment" "codebuild_fargate_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role = aws_iam_role.codebuild_role.name
}