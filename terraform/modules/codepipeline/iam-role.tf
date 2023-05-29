# data source of codepipeline policy
data "aws_iam_policy" "pipeline_role" {
  name = "AWSCodePipelineServiceRole-ap-northeast-2-zw-jujy-log-pipeline"
}

# codepipeline service role
resource "aws_iam_role" "codepipeline_service_role" {
  name               = "${var.tag}-CodePipelineServiceRole-${var.repo_name}"
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

resource "aws_iam_role_policy_attachment" "attached_policy" {
  role       = aws_iam_role.codepipeline_service_role.name
  policy_arn = data.aws_iam_policy.pipeline_role.arn
}