resource "aws_iam_role" "codepipeline_role" {
  name = var.codepipeline_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "codepipeline_role_policy_document" {
  statement {
    sid       = ""
    actions   = ["cloudwatch:*", "s3:*", "codebuild:*", "codecommit:*"]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    sid       = ""
    actions   = ["codestar-connections:UseConnection"]
    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "codepipeline_role_policy" {
  name        = var.codepipeline_role_policy_name
  path        = "/"
  description = "CodePipeline policy"
  policy      = data.aws_iam_policy_document.codepipeline_role_policy_document.json
}

resource "aws_iam_role_policy_attachment" "codepipeline_role_policy_attachment" {
  policy_arn = aws_iam_policy.codepipeline_role_policy.arn
  role       = aws_iam_role.codepipeline_role.id
}