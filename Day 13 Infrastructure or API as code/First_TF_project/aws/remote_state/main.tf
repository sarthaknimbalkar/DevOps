# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE AN S3 BUCKET AND DYNAMODB TABLE FOR TERRAFORM BACKEND
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION
# This module has been updated with 0.12 syntax, making it incompatible with versions below 0.12.
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.12"
}

# ----------------------------------------------------------------------------------------------------------------------
# CONFIGURE AWS PROVIDER
# ----------------------------------------------------------------------------------------------------------------------

provider "aws" {}

# ----------------------------------------------------------------------------------------------------------------------
# RETRIEVE AWS ACCOUNT INFORMATION
# ----------------------------------------------------------------------------------------------------------------------

data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = "us-west-2"  # Optional: Set the AWS region if not defined elsewhere
}

# ----------------------------------------------------------------------------------------------------------------------
# CREATE S3 BUCKET FOR REMOTE STATE STORAGE
# ----------------------------------------------------------------------------------------------------------------------

resource "aws_s3_bucket" "terraform_state" {
  bucket = "${local.account_id}-terraform-states"

  # Enable versioning to maintain state file history
  versioning {
    enabled = true
  }

  # Enable server-side encryption using AES-256
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  # (Optional) Specify lifecycle rules, logging, etc. for better management
  lifecycle_rule {
    id      = "expire-old-versions"
    enabled = true

    noncurrent_version_expiration {
      days = 30  # Retain non-current versions for 30 days before expiring
    }
  }
}

# ----------------------------------------------------------------------------------------------------------------------
# CREATE DYNAMODB TABLE FOR STATE LOCKING
# ----------------------------------------------------------------------------------------------------------------------

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  # (Optional) Add tags for better resource management
  tags = {
    Name        = "Terraform Lock Table"
    Environment = "Development"
  }
}
