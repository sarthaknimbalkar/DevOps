#!/bin/bash

###################
#
# Author: Sarthak
#
# Date: 26th Aug, 2024
#
# Description: This script provides various functions to interact with the GitHub API.
#              It allows users to manage repositories, list collaborators, create issues,
#              check repository health, and more. The script is designed to be user-friendly
#              and includes a helper function to guide users through the available options.
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
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

# Function to list all collaborators with their permissions
function list_collaborators_with_permissions {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | "\(.login): \(.permissions)"')"
    
    if [[ -z "$collaborators" ]]; then
        echo "No collaborators found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Collaborators and their permissions for ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

# Function to create a new issue
function create_issue {
    local title="$1"
    local body="$2"
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/issues"
    
    curl -s -X POST -H "Authorization: token ${TOKEN}" -H "Accept: application/vnd.github.v3+json" \
        -d "{\"title\": \"$title\", \"body\": \"$body\"}" "$API_URL/$endpoint"
}

# Function to list open issues
function list_open_issues {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/issues?state=open"
    issues="$(github_api_get "$endpoint" | jq -r '.[] | "\(.number): \(.title)"')"
    
    if [[ -z "$issues" ]]; then
        echo "No open issues found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Open issues for ${REPO_OWNER}/${REPO_NAME}:"
        echo "$issues"
    fi
}

# Function to merge a pull request
function merge_pull_request {
    local pr_number="$1"
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/pulls/${pr_number}/merge"
    
    curl -s -X PUT -H "Authorization: token ${TOKEN}" -H "Accept: application/vnd.github.v3+json" \
        -d '{"commit_message": "Merging PR #'"${pr_number}"'"}' "$API_URL/$endpoint"
}

# Function to check repository health
function check_repository_health {
    local issues_count=$(github_api_get "repos/${REPO_OWNER}/${REPO_NAME}/issues?state=open" | jq '. | length')
    local pulls_count=$(github_api_get "repos/${REPO_OWNER}/${REPO_NAME}/pulls?state=open" | jq '. | length')
    local last_commit_date=$(github_api_get "repos/${REPO_OWNER}/${REPO_NAME}/commits" | jq -r '.[0].commit.committer.date')

    echo "Repository Health for ${REPO_OWNER}/${REPO_NAME}:"
    echo "Open Issues: $issues_count"
    echo "Open Pull Requests: $pulls_count"
    echo "Last Commit Date: $last_commit_date"
}

# Function to monitor repository events
function monitor_events {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/events"
    events="$(github_api_get "$endpoint" | jq -r '.[] | "\(.type) by \(.actor.login) at \(.created_at)"')"
    
    echo "Recent events for ${REPO_OWNER}/${REPO_NAME}:"
    echo "$events"
}

# Function to back up a repository
function backup_repository {
    local backup_dir="$1"
    git clone "https://github.com/${REPO_OWNER}/${REPO_NAME}.git" "$backup_dir/${REPO_NAME}"
}

# Helper function to guide the user in navigating available options
function display_help {
    echo "Available commands:"
    echo "1. List users with read access: ./script.sh list_read_access"
    echo "2. List all collaborators with permissions: ./script.sh list_collaborators"
    echo "3. Create a new issue: ./script.sh create_issue <title> <body>"
    echo "4. List open issues: ./script.sh list_open_issues"
    echo "5. Merge a pull request: ./script.sh merge_pr <pr_number>"
    echo "6. Check repository health: ./script.sh check_health"
    echo "7. Monitor repository events: ./script.sh monitor_events"
    echo "8. Backup repository: ./script.sh backup <backup_directory>"
    echo
    echo "Make sure to set the GITHUB_USERNAME and GITHUB_ACCESS_TOKEN environment variables."
}

# Main script execution
if [[ -z "$USERNAME" || -z "$TOKEN" || -z "$REPO_OWNER" || -z "$REPO_NAME" ]]; then
    echo "Please set the required environment variables or provide command-line arguments."
    display_help
    exit 1
fi

# Check command-line arguments for specific actions
case "$1" in
    list_read_access)
        list_users_with_read_access
        ;;
    list_collaborators)
        list_collaborators_with_permissions
        ;;
    create_issue)
        create_issue "$2" "$3"
        ;;
    list_open_issues)
        list_open_issues
        ;;
    merge_pr)
        merge_pull_request "$2"
        ;;
    check_health)
        check_repository_health
        ;;
    monitor_events)
        monitor_events
        ;;
    backup)
        backup_repository "$2"
        ;;
    *)
        echo "Invalid command. Use './script.sh help' for a list of available commands."
        display_help
        ;;
esac
