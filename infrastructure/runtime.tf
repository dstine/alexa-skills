// Manages infrastructure for running application code
// A lambda function and associated resources

resource "aws_iam_policy" "alexa_run" {
  name        = "${var.aws_resource_name_run}"
  description = "Access for Alexa Lambda function"
  path        = "/"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": [
        "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:${aws_cloudwatch_log_group.alexa_run.name}:*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "cloudwatch:PutMetricData"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "alexa_run" {
  name        = "${var.aws_resource_name_run}"
  description = "Runtime role for Alexa Lambda function"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "alexa_run" {
  role       = "${aws_iam_role.alexa_run.name}"
  policy_arn = "${aws_iam_policy.alexa_run.arn}"
}

resource "aws_lambda_function" "alexa_run" {
  function_name = "${var.aws_resource_name_run}"
  role          = "${aws_iam_role.alexa_run.arn}"
  handler       = "com.github.dstine.alexa.example.ExampleStreamHandler::handleRequest"
  runtime       = "java8"
  memory_size   = "256"
  timeout       = "30"
  s3_bucket     = "${var.deploy_bucket_name}"
  s3_key        = "alexa-skills.zip"

  environment {
    variables = {
      ALEXA_SKILL_ID = "${var.env_ALEXA_SKILL_ID}"
    }
  }

  tags {
    project   = "alexa-skills"
    terraform = "true"
  }
}

resource "aws_cloudwatch_log_group" "alexa_run" {
  name = "/aws/lambda/${var.aws_resource_name_run}"

  tags {
    project   = "alexa-skils"
    terraform = "true"
  }
}

