#!bin/bash

###################
#
# Author: Sarthak
#
# Date: 26th Aug, 2024
#
# This script will report the AWS usage report
#
####################

# AWS S3
# AWS EC2
# AWS Lambda
# AWS IAM Users

set -x


# list s3 buckets
echo 'print the list of s3 buckets'
aws s3 ls

# list EC2 Instance
echo 'print the list of ec2 instance'
aws ec2 describe-instances | jq '.Reservation[].Instances[].InstanceId'

# list AWS lambda
echo 'print the list of aws lambda'
aws lambda list-functions

# list IAM users
echo 'print the list of iam users'
aws iam list-users


