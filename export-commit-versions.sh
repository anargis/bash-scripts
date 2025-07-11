#!/bin/bash
#
# Description:
# Clones a GitHub repository and exports files from each commit into separate folders,
# enabling access to all historical versions of the project.
#
# Usage:
# chmod +x export-commit-versions.sh
# ./export-commit-versions.sh <github_owner> <repo_name>

# Clone the specified GitHub repository using the provided owner and repository name
git clone https://github.com/"$1"/"$2".git

# Change directory into the cloned repository; exit if it fails
cd "$2" || { echo "Failed to enter repository directory"; exit 1; }

# Create a directory outside the repo to store all exported commit versions
mkdir -p ../"${2}_versions"

# Loop through all commits from oldest to newest
for commit in $(git rev-list --reverse HEAD); do
    echo "Exporting files from commit $commit"

    # Create a directory named after the commit hash to store files
    mkdir -p ../"${2}_versions"/"$commit"

    # Export the commit contents into the corresponding directory
    git archive "$commit" | tar -x -C ../"${2}_versions"/"$commit"

    echo "Commit $commit extracted"
done
