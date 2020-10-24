terraform {
  backend "s3" {
    bucket = "aartykhov-tf-go-rollback-resource-on-failure"
    key = "tf-go-rollback-resource-on-failure.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
}

# Define a Lambda function.
#
# The handler is the name of the executable for go1.x runtime.
resource "aws_lambda_function" "test" {
  function_name    = "tf-go-rollback-resource-on-failure"
  filename         = "tf-go-rollback-resource-on-failure.zip"
  handler          = "tf-go-rollback-resource-on-failure"
  source_code_hash = filebase64sha256("tf-go-rollback-resource-on-failure.zip")
  role             = aws_iam_role.test.arn
  runtime          = "go1.x"
  memory_size      = 128
  timeout          = 1
}

# A Lambda function may access to other AWS resources such as S3 bucket. So an
# IAM role needs to be defined. This example does not access to
# any resource, so the role is empty.
#
# The date 2012-10-17 is just the version of the policy language used here [1].
#
# [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_version.html
resource "aws_iam_role" "test" {
  name               = "test"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": {
    "Action": "sts:AssumeRole",
    "Principal": {
      "Service": "lambda.amazonaws.com"
    },
    "Effect": "Allow"
  }
}
POLICY
}
