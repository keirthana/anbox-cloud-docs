#!/bin/bash

set -euo pipefail

# Define variables
REPO_URL="https://github.com/keirthana/anbox-cloud-docs.git"
CLONE_DIR="anbox-cloud-docs"
BRANCH="main"
RELEASE_NOTES_DIR="reference/release-notes"
VERSION_FILE=".base_version"
REMOTE="origin"  # This will point to the original repo after clone

# Step 1: Clone the repository if it does not already exist
if [ ! -d "$CLONE_DIR" ]; then
  echo "Cloning the repository..."
  git clone "$REPO_URL"
fi

# Step 2: Navigate to the cloned directory
cd "$CLONE_DIR" || exit 1

# Step 3: Fetch the latest changes from the origin repository's main branch
echo "Fetching and checking out branch $BRANCH from origin"
git fetch "$REMOTE" "$BRANCH"
git checkout "$BRANCH"
git pull "$REMOTE" "$BRANCH"  # Ensure you have the latest changes from origin

# Step 4: Read the current version from the .base_version file
if [ -f "$VERSION_FILE" ]; then
  CURRENT_VERSION=$(cat "$VERSION_FILE")
  echo "Current base version: $CURRENT_VERSION"
else
  echo "Error: Base version file '$VERSION_FILE' not found."
  exit 1
fi

# Step 5: Determine the next version (bump minor version, reset patch)
IFS='.' read -r -a version_parts <<< "$CURRENT_VERSION"
MAJOR=${version_parts[0]}
MINOR=${version_parts[1]}
NEXT_MINOR=$((MINOR + 1))
NEXT_VERSION="${MAJOR}.${NEXT_MINOR}.0"

# Step 6: Check if the release note file exists for the current version
RELEASE_FILE="${RELEASE_NOTES_DIR}/${CURRENT_VERSION}.md"
echo "Checking for release note file '$RELEASE_FILE'"
if [ -f "$RELEASE_FILE" ]; then
  echo "Release note file '$RELEASE_FILE' found. Proceeding with version update..."

  # Step 7: Update the base version file
  echo "Updating base version to $NEXT_VERSION"
  echo "$NEXT_VERSION" > "$VERSION_FILE"

  # Step 8: Commit the change
  git add "$VERSION_FILE"
  git commit -m "Update base version to $NEXT_VERSION"

  # Step 9: Create new branch and push it to your fork
  # NEW_BRANCH="update-version-to-${NEXT_VERSION}"
  # git checkout -b "$NEW_BRANCH"
  # git push "$REMOTE" "$NEW_BRANCH"

  # Step 10: **PR creation skipped**, print the details for manual creation
  echo "PR creation skipped. You would create a PR with the following details:"
  echo "Title: Update base version to $NEXT_VERSION"
  echo "Branch: $NEW_BRANCH"
  echo "Base Branch: $BRANCH"
  echo "Description: This PR updates the base version to $NEXT_VERSION."

else
  echo "Release note file '$RELEASE_FILE' not found. No changes will be made."
  exit 0
fi
