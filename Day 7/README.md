# AWS Resource Usage Tracker

## Overview
This project provides a shell script designed to monitor and report AWS resource usage. The key benefits of moving to cloud infrastructure include manageability and cost-effectiveness, allowing organizations to pay only for what they use. However, it is essential to track and manage resource usage actively, as cloud providers charge for idle or unused resources.

### Why Use This Script?
- 🏗 **Automation**: Automates daily AWS usage reporting for resources like EC2 instances, S3 buckets, Lambda functions, and IAM users.
- 💰 **Cost Management**: Helps monitor resource usage to avoid unnecessary expenses by identifying unused or underutilized resources.
- 🛠️ **Simplicity**: Provides an easy way to generate reports that can be integrated into dashboards for continuous monitoring.
- 🔍 **Customization**: The script uses AWS CLI commands and can be easily modified based on specific organizational needs.

### Key Features
- **Resource Tracking**: Tracks critical AWS services, including EC2 instances, S3 buckets, Lambda functions, and IAM users.
- **Debugging**: Enhanced with comments, print statements, and the `set -x` command for better readability and easier debugging.
- **JSON Parsing**: Utilizes the `jq` command to filter and simplify the output from AWS CLI commands, making the report more relevant and readable.
- **Scheduled Execution**: Can be run automatically at specified intervals using cron jobs (Linux/MacOS) or Task Scheduler (Windows).
- **Notifications**: Supports automated email or Slack notifications after the report is generated.

### How to Use
1. **Ensure AWS CLI is Installed and Configured**: The script relies on the AWS CLI, so make sure it is installed and configured with the appropriate IAM permissions.
2. **Run the Script**: Execute the script manually or set it up to run automatically using a cron job or Windows Task Scheduler.
3. **Customize**: Tailor the script to your organization's needs by adding or modifying the AWS resources being tracked.

### Installation
1. Clone this repository:
   ```bash
   git clone [https://github.com/sarthaknimbalkar/DevOps/aws-resource-tracker.git](https://github.com/sarthaknimbalkar/DevOps.git)
   ```
2. Make the script executable:
   ```bash
   chmod +x resource_tracker.sh
   ```
3. Optionally, schedule the script using a cron job (Linux/MacOS) or Task Scheduler (Windows) for automated execution.
