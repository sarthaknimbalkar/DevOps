#!/bin/bash


###################
#
# Author: Sarthak
#
# Date: 26th Aug, 2024
#
# Description: This script interacts with the GitHub API to list users 
#              who have read access to a specified repository. It requires 
#              a GitHub username and a personal access token for authentication.
#              Users can be specified via command-line arguments or environment 
#              variables. The script checks for the necessary credentials and 
#              repository information, then retrieves and displays the list of 
#              collaborators with read access.
#
###################

# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token
USERNAME="${GITHUB_USERNAME:-$username}"
TOKEN="${GITHUB_ACCESS_TOKEN:-$token}"

# User and Repository information
REPO_OWNER="${1:-$GITHUB_REPO_OWNER}"
REPO_NAME="${2:-$GITHUB_REPO_NAME}"

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -H "Authorization: token ${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

# Helper function to guide the user in setting up the script
function setup_guide {
    echo "To run this script, you need to set the following environment variables:"
    echo "- GITHUB_USERNAME: Your GitHub username"
    echo "- GITHUB_ACCESS_TOKEN: Your GitHub personal access token"
    echo "- GITHUB_REPO_OWNER: The owner of the repository (e.g., 'octocat')"
    echo "- GITHUB_REPO_NAME: The name of the repository (e.g., 'Hello-World')"
    echo
    echo "Alternatively, you can provide the repository owner and name as command-line arguments:"
    echo "./list-users.sh <repo_owner> <repo_name>"
    echo
    echo "Make sure to replace <repo_owner> and <repo_name> with the actual values."
    echo "If you don't have a personal access token, you can create one by following these steps:"
    echo "1. Go to https://github.com/settings/tokens"
    echo "2. Click on 'Generate new token'"
    echo "3. Select the necessary scopes (e.g., 'repo' for accessing public and private repositories)"
    echo "4. Click on 'Generate token'"
    echo "5. Copy the generated token and set it as the GITHUB_ACCESS_TOKEN environment variable."
}

# Main script

# Check if required variables are set
if [[ -z "$USERNAME" || -z "$TOKEN" || -z "$REPO_OWNER" || -z "$REPO_NAME" ]]; then
    echo "Please set the required environment variables or provide command-line arguments."
    setup_guide
    exit 1
fi

# Notify user of the action being taken
echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
