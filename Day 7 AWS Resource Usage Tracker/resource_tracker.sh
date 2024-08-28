#!/bin/bash

###################
#
# Author: Sarthak
#
# Date: 26th Aug, 2024
#
# Description: This script generates an AWS usage report by listing
#              S3 buckets, EC2 instances, Lambda functions, and IAM users.
#
###################

# Enable debugging
set -x

# Function to list S3 buckets
list_s3_buckets() {
    echo "=== Listing S3 Buckets ==="
    aws s3 ls || { echo "Failed to list S3 buckets"; exit 1; }
    echo ""
}

# Function to list EC2 instances
list_ec2_instances() {
    echo "=== Listing EC2 Instances ==="
    aws ec2 describe-instances | jq -r '.Reservations[].Instances[].InstanceId' || { echo "Failed to list EC2 instances"; exit 1; }
    echo ""
}

# Function to list AWS Lambda functions
list_lambda_functions() {
    echo "=== Listing AWS Lambda Functions ==="
    aws lambda list-functions || { echo "Failed to list Lambda functions"; exit 1; }
    echo ""
}

# Function to list IAM users
list_iam_users() {
    echo "=== Listing IAM Users ==="
    aws iam list-users || { echo "Failed to list IAM users"; exit 1; }
    echo ""
}

# Execute functions
list_s3_buckets
list_ec2_instances
list_lambda_functions
list_iam_users

# End of script
echo "=== AWS Usage Report Completed ==="
