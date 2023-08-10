#!/bin/bash

# Determine the type of change: major, minor, or patch
# For demonstration, let's assume a simple logic based on commit messages
LAST_COMMIT_MSG=$(git log -1 --pretty=format:%s)
if [[ $LAST_COMMIT_MSG == *"BREAKING CHANGE"* ]]; then
    CHANGE_TYPE="major"
elif [[ $LAST_COMMIT_MSG == *"feat:"* ]]; then
    CHANGE_TYPE="minor"
else
    CHANGE_TYPE="patch"
fi

# Retrieve the current version from the latest Docker image tag
CURRENT_VERSION=$(docker images -q my-node-app | awk '{print substr($2, 1, 12)}')

# Increment version number based on the change type
IFS='.' read -ra PARTS <<< "$CURRENT_VERSION"
MAJOR=${PARTS[0]}
MINOR=${PARTS[1]}
PATCH=${PARTS[2]}
case "$CHANGE_TYPE" in
    major) ((MAJOR++)); MINOR=0; PATCH=0;;
    minor) ((MINOR++)); PATCH=0;;
    patch) ((PATCH++));;
esac

# Create the new version tag
NEW_VERSION="$MAJOR.$MINOR.$PATCH"

# Build the Docker image with the new version tag
docker build -t my-node-app:$NEW_VERSION .

# Tag the latest build with "latest"
docker tag my-node-app:$NEW_VERSION my-node-app:latest

# Print a message
echo "Docker image built with version: $NEW_VERSION"