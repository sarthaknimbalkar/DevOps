# README for Building a CI/CD Pipeline on AWS

## Overview

This guide explains how to set up a Continuous Integration/Continuous Deployment (CI/CD) pipeline on AWS using AWS CodePipeline. The pipeline will automate the deployment of a sample Node.js application, the "Musician App," from a GitHub repository to AWS Elastic Beanstalk. This process will trigger deployments automatically upon code commits.

## Prerequisites

- **AWS Account**: You need an active AWS account.
- **GitHub Account**: Ensure you have a GitHub account with access to the "Musician App" repository.
- **AWS CLI**: Install and configure the AWS Command Line Interface (CLI) on your local machine.

## Steps to Set Up the CI/CD Pipeline

### 1. Clone the Musician App Repository

First, clone the "Musician App" repository from GitHub to your local machine.

```bash
git clone https://github.com/sarthaknimbalkar/DevOps.git
cd Day 10 Deploy and Expose an App to AWS
```

### 2. Create an AWS CodeCommit Repository

1. Sign in to the AWS Management Console and navigate to the **CodeCommit** service.
2. Click on **Create repository**.
3. Enter a name for your repository (e.g., `musician-app-repo`) and click **Create**.
4. Copy the SSH clone URL provided.

### 3. Push Code to CodeCommit

Add the CodeCommit repository as a remote and push your local code.

```bash
git remote add codecommit <SSH clone URL>
git push codecommit master
```

### 4. Set Up AWS Elastic Beanstalk

1. Go to the **Elastic Beanstalk** service in the AWS Management Console.
2. Click on **Create a new application**.
3. Enter an application name (e.g., `MusicianApp`) and select the platform as **Node.js**.
4. Click **Create environment** and follow the prompts to set up your environment.

### 5. Create a CodeDeploy Application

1. Navigate to the **CodeDeploy** service in the AWS Management Console.
2. Click on **Applications** and then **Create application**.
3. Name your application (e.g., `MusicianApp`) and select **EC2/On-Premises** as the compute platform.
4. Create a deployment group linked to your Elastic Beanstalk environment.

### 6. Create the CI/CD Pipeline in CodePipeline

1. Open the **CodePipeline** service in the AWS Management Console.
2. Click on **Create pipeline**.
3. Name your pipeline (e.g., `MusicianAppPipeline`).
4. For **Service role**, select **New service role**.
5. In the **Source stage**:
   - Select **CodeCommit** as the source provider.
   - Choose the repository you created earlier and select the branch (e.g., `master`).
6. Skip the build stage by selecting **Skip build stage**.
7. In the **Deploy stage**:
   - Select **AWS CodeDeploy**.
   - Choose the application and deployment group you created earlier.
8. Review your settings and click **Create pipeline**.

### 7. Configure GitHub Webhooks (Optional)

To trigger the pipeline automatically on code commits:

1. Go to your GitHub repository settings.
2. Click on **Webhooks** and then **Add webhook**.
3. Enter the payload URL provided by AWS CodePipeline.
4. Set the content type to `application/json`.
5. Choose to send the webhook for just the `push` event and save.

### 8. Testing the Pipeline

Make changes to your application locally, commit, and push to the CodeCommit repository:

```bash
git add .
git commit -m "Update application"
git push codecommit master
```

Monitor the pipeline in the AWS CodePipeline console to see the deployment process.

### 9. Health Check URL

Add a health check endpoint in your application that returns a 200 OK message. This can be used to verify that the application is running correctly after deployment.

## Conclusion

Following these steps will set up a fully automated CI/CD pipeline for your Node.js application on AWS. This pipeline will facilitate continuous integration and deployment, enhancing your development workflow.

Citations:
[1] https://www.youtube.com/watch?v=lMlORLHF-Hc
[2] https://spot.io/resources/ci-cd/aws-ci-cd-the-basics-and-a-quick-tutorial/
[3] https://www.geeksforgeeks.org/how-to-build-a-ci-cd-pipeline-with-aws/
[4] https://www.youtube.com/watch?v=NwzJCSPSPZs
[5] https://aws.amazon.com/codepipeline/
[6] https://docs.aws.amazon.com/codepipeline/latest/userguide/tutorials-simple-s3.html
[7] https://aws.amazon.com/getting-started/hands-on/continuous-deployment-pipeline/
[8] https://docs.aws.amazon.com/codepipeline/latest/userguide/tutorials.html