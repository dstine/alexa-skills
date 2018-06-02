// Manages infrastructure for deploying application code updates
// A user with ability to push code to S3

resource "aws_s3_bucket" "alexz_deploy" {
  bucket = "${var.deploy_bucket_name}"
  acl    = "private"

  lifecycle {
    prevent_destroy = "true"
  }

  tags {
    terraform = "true"
  }
}

resource "aws_iam_user" "alexa_deploy" {
  name = "${var.aws_resource_name_deploy}"
  path = "/"
}

resource "aws_iam_group" "alexa_deploy" {
  name = "${var.aws_resource_name_deploy}"
  path = "/"
}

resource "aws_iam_group_membership" "alexa_deploy" {
  name  = "${var.aws_resource_name_deploy}"
  users = ["${aws_iam_user.alexa_deploy.name}"]
  group = "${aws_iam_group.alexa_deploy.name}"
}

resource "aws_iam_policy" "alexa_deploy" {
  name        = "${var.aws_resource_name_deploy}"
  description = "Access for Alexa skills deployment"
  path        = "/"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListAllMyBuckets"
      ],
      "Resource": "arn:aws:s3:::*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::${var.deploy_bucket_name}",
        "arn:aws:s3:::${var.deploy_bucket_name}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_group_policy_attachment" "alexa_deploy" {
  group      = "${aws_iam_group.alexa_deploy.name}"
  policy_arn = "${aws_iam_policy.alexa_deploy.arn}"
}
