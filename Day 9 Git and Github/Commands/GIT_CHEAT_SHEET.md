# Git Cheat Sheet for DevOps Engineers

## Table of Contents
1. [Introduction](#introduction)
2. [Essential Git Commands](#essential-git-commands)
3. [Branching Strategies](#branching-strategies)
4. [Merging vs. Rebasing](#merging-vs-rebasing)
5. [Working with Remote Repositories](#working-with-remote-repositories)
6. [Commit Message Best Practices](#commit-message-best-practices)
7. [Undoing and Recovering Changes](#undoing-and-recovering-changes)
8. [Automating Workflows with Git Hooks](#automating-workflows-with-git-hooks)
9. [Useful Resources](#useful-resources)

## Introduction
Git is a critical tool for DevOps engineers, enabling efficient version control, seamless collaboration, and process automation. This cheat sheet covers the key Git commands, workflows, and best practices you need to excel in a DevOps environment.

## Essential Git Commands

### Initializing a Repository
```bash
git init
```
Initializes a new Git repository in the current directory, creating a `.git` folder to track version history. Often used when starting a new project.

### Managing Files
```bash
git add <file>
```
Stages a specific file for the next commit, ensuring it will be included in the version history.

```bash
git add .
```
Stages all files in the current directory, making them ready for commit.

```bash
git rm <file>
```
Removes a file from both the working directory and staging area. Useful when you want to permanently delete files from the project.

```bash
git mv <old_file> <new_file>
```
Renames or moves a file while preserving its version history, which helps maintain a clean project structure.

### Recording Changes
```bash
git commit -m "Descriptive message"
```
Captures the current state of staged changes with a descriptive message, creating a snapshot in the repository history.

```bash
git commit --amend
```
Modifies the most recent commit. Useful for fixing small errors in the last commit, such as a typo in the message or forgetting to stage a file.

### Inspecting History
```bash
git log
```
Displays the commit history with details like commit IDs, author, date, and messages. Adding options like `--oneline` or `--graph` can help visualize complex histories.

```bash
git diff
```
Shows differences between commits, the working directory, and the staging area, helping you understand what has changed before committing.

## Branching Strategies

### Feature Branching
Use a dedicated branch for each new feature or bug fix to isolate development, ensuring that the main branch remains stable.
```bash
git checkout -b feature/new-feature
```
This creates and switches to a new branch named `feature/new-feature`.

### Release Branching
When preparing a release, create a dedicated branch to stabilize the code before deployment. This allows teams to focus on testing and bug fixes without affecting ongoing development.
```bash
git checkout -b release/v1.0
```

### Hotfix Branching
For critical fixes in production, create a hotfix branch directly off the main branch. This ensures the quickest path to resolving the issue.
```bash
git checkout -b hotfix/urgent-fix
```

## Merging vs. Rebasing

### Merging
Merging combines two branches while preserving the commit history from both. This method maintains a comprehensive view of all development activity.
```bash
git merge feature/new-feature
```
Merging is ideal for when you want to keep a record of feature development paths.

### Rebasing
Rebasing moves or "replays" commits from one branch onto another, creating a linear and cleaner history.
```bash
git rebase develop
```
Use rebasing when you want a streamlined commit history, especially in team workflows where readability matters.

### When to Use Each
- **Merge**: When preserving the complete history is important, especially for large teams.
- **Rebase**: When you prefer a clean, linear history without branch merges cluttering the log.

## Working with Remote Repositories

### Cloning a Repository
```bash
git clone <repository-url>
```
Creates a local copy of a remote repository, setting up the default remote as `origin`.

### Adding a Remote Repository
```bash
git remote add origin <repository-url>
```
Associates your local repository with a remote repository, often named `origin`.

### Fetching Changes
```bash
git fetch origin
```
Downloads new commits and branches from the remote repository without affecting your local work. Use this to see what’s new before merging or pulling.

### Pulling Changes
```bash
git pull origin main
```
Fetches and automatically merges changes from the remote `main` branch into your current branch. It’s a shorthand for `git fetch` followed by `git merge`.

### Pushing Changes
```bash
git push origin main
```
Uploads local commits to the remote `main` branch, making your updates available to others.

## Commit Message Best Practices

- **Use the Imperative Mood**: Write messages like commands, e.g., "Fix bug" instead of "Fixed bug".
- **Keep It Brief**: Limit the subject line to 50 characters for clarity in logs and interfaces.
- **Explain the Why**: In the body, give context or reasoning for your changes, especially when it's not obvious from the code.
- **Reference Issues and Tickets**: Include IDs or URLs for related issues, e.g., "Fixes #123", ensuring traceability.

## Undoing and Recovering Changes

### Resetting Changes
```bash
git reset <commit>
```
Moves the HEAD pointer and optionally modifies the working directory and staging area. Use `--soft` to keep changes in the staging area or `--hard` to discard them.

### Reverting a Commit
```bash
git revert <commit>
```
Creates a new commit that undoes a previous commit without altering the commit history. Useful for safely rolling back changes in a collaborative environment.

### Stashing Changes
```bash
git stash
```
Temporarily saves uncommitted changes, allowing you to switch branches or perform other tasks without losing your work. Use `git stash pop` to reapply stashed changes.

## Automating Workflows with Git Hooks
Git hooks are scripts that trigger at certain points in the Git process, allowing for automation tasks like code linting, testing, or notifications.

### Common Hooks
- **Pre-commit**: Run tests, lint code, or check formatting before a commit is finalized.
- **Post-commit**: Trigger actions like notifying teammates or updating issue trackers.
- **Pre-push**: Ensure that code passes tests and validations before it’s pushed to the remote repository.

## Useful Resources
- [Pro Git Book](https://git-scm.com/book/en/v2): A comprehensive guide to Git.
- [Git Documentation](https://git-scm.com/doc): The official and detailed reference for Git.
- [Atlassian Git Tutorials](https://www.atlassian.com/git/tutorials): Hands-on guides for beginners and advanced users.
- [GitHub Learning Lab](https://lab.github.com/): Interactive courses and projects for learning Git.
