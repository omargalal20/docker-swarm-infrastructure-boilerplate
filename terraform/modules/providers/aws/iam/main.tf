##############################################################
#
# IAM Role for CI/CD in Docker Swarm
#
##############################################################


resource "aws_iam_role" "cicd_iam_role" {
  name = "${var.namespace}-cicd-iam-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "cicd_iam_policy" {
  name        = "${var.namespace}-cicd-iam-policy"
  description = "IAM policy for ${var.namespace}-cicd instance"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload",
        "ecr:PutImage"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "cicd_iam_role_policy_attachment" {
  policy_arn = aws_iam_policy.cicd_iam_policy.arn
  role       = aws_iam_role.cicd_iam_role.name
}
