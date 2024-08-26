# GitHub API Interaction Script

## Overview

This script provides a comprehensive set of functions for interacting with the GitHub API. It allows users to manage repositories, list collaborators, create issues, check repository health, and more. The script is designed to be user-friendly and includes a helper function to guide users through the available options.

## Features

- **API Interaction**: Functions for making GET requests to the GitHub API.
- **Collaborator Management**: Functions to list collaborators and their permissions.
- **Issue Management**: Functions to create and list issues.
- **Pull Request Management**: Function to merge pull requests.
- **Repository Health Check**: Function to assess the repository's status.
- **Event Monitoring**: Function to log recent repository events.
- **Backup Functionality**: Function to clone the repository to a specified directory.
- **User Guidance**: A helper function to display available commands and usage instructions.

## Prerequisites

- **GitHub account**: You need a GitHub account to use this script.
- **Personal access token**: You need to generate a personal access token with the necessary permissions to interact with the GitHub API. You can create a token by following these steps:
  1. Go to [GitHub Settings - Tokens](https://github.com/settings/tokens).
  2. Click on **Generate new token**.
  3. Select the necessary scopes (e.g., 'repo' for accessing public and private repositories).
  4. Click on **Generate token**.
  5. Copy the generated token and set it as the `GITHUB_ACCESS_TOKEN` environment variable.

## Environment Variables

Set the following environment variables before running the script:

- `GITHUB_USERNAME`: Your GitHub username.
- `GITHUB_ACCESS_TOKEN`: Your GitHub personal access token.
- `GITHUB_REPO_OWNER`: The owner of the repository (e.g., 'octocat').
- `GITHUB_REPO_NAME`: The name of the repository (e.g., 'Hello-World').

## Running the Script

1. Set the required environment variables in your terminal:

   ```bash
   export GITHUB_USERNAME="your_username"
   export GITHUB_ACCESS_TOKEN="your_token"
   export GITHUB_REPO_OWNER="repository_owner"
   export GITHUB_REPO_NAME="repository_name"
   ```

2. Execute the script with the desired command:

   ```bash
   ./script.sh <command> [arguments]
   ```

   Replace `<command>` with one of the available commands (e.g., `list_read_access`, `create_issue`, `check_health`) and provide any necessary arguments.

3. If you need guidance on the available commands and usage, run:

   ```bash
   ./script.sh help
   ```

   This will display a list of available commands and their descriptions.

## Available Commands

- `list_read_access`: Lists users with read access to the specified repository.
- `list_collaborators`: Lists all collaborators with their permissions for the specified repository.
- `create_issue <title> <body>`: Creates a new issue in the specified repository with the given title and body.
- `list_open_issues`: Lists all open issues in the specified repository.
- `merge_pr <pr_number>`: Merges the specified pull request in the repository.
- `check_health`: Checks the health of the specified repository by displaying the number of open issues, open pull requests, and the date of the last commit.
- `monitor_events`: Monitors and logs recent events in the specified repository.
- `backup <backup_directory>`: Backs up the specified repository by cloning it to the provided backup directory.

## Contributing

If you find any issues or have suggestions for improvements, feel free to create a new issue or submit a pull request. Contributions are welcome!