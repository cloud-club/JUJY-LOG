# codebuild service role
resource "aws_iam_role" "codebuild_service_role" {
  name               = "${var.tag}-CodeBuildServiceRole-${var.repo_name}"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "codebuild.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
  EOF
}

# customer managed policies
resource "aws_iam_role_policy" "customer_managed_policies" {
  name = "${var.tag}-CodeBuildBasePolicy-${var.repo_name}"
  role = aws_iam_role.codebuild_service_role.name
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Resource" : var.log_resource,
        "Action" : var.logs_actions
      },
      {
        "Effect" : "Allow",
        "Resource" : var.s3_resource,
        "Action" : var.s3_actions
      },
      {
        "Effect" : "Allow",
        "Resource" : var.codecommit_resource,
        "Action" : var.codecommit_actions
      },
      {
        "Effect" : "Allow",
        "Action" : var.codebuild_actions,
        "Resource" : var.codebuild_resource
      }
    ]
  })
}

# AWS managed policy
data "aws_iam_policy" "ecr_policy" {
  name = "AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_role_policy_attachment" "attached_policy" {
  role       = aws_iam_role.codebuild_service_role.name
  policy_arn = data.aws_iam_policy.ecr_policy.arn
}