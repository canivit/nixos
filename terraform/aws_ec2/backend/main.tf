terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.56"
    }
  }
}

variable "region" {
  type = string
  nullable = false
}

provider "aws" {
  profile = "admin"

  region = var.region
}

resource "aws_s3_bucket" "main" {
  bucket_prefix = "nix-cfg-terraform-state"
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "main" {
  name = "nix-cfg-terraform-state"

  read_capacity = 1

  write_capacity = 1

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

data "aws_iam_policy_document" "main" {
  statement {
    actions = [ "s3:ListBucket" ]

    resources = [ aws_s3_bucket.main.arn ]
  }

  statement {
    actions = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]

    resources = [ "${aws_s3_bucket.main.arn}/*" ]
  }

  statement {
    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
    ]

    resources = [
      "${aws_dynamodb_table.main.arn}/nixos-in-production"
    ]
  }
}

data "aws_caller_identity" "main" { }

resource "aws_iam_user_policy" "main" {
  policy = data.aws_iam_policy_document.main.json

  user = "${split("/", data.aws_caller_identity.main.arn)[1]}"
}

output "bucket" {
  value = aws_s3_bucket.main.id
}
