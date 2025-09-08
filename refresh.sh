#!/bin/bash
#
# Ubuntu/Linux equivalent of dev.bat
# 
# Usage:
#   chmod +x refresh.sh
#   ./refresh.sh
#
# This script downloads the specs/ folders from specific branches of the
# Microsoft WindowsAppSDK repository into corresponding local directories.

set -e

REPO="https://github.com/microsoft/WindowsAppSDK.git"
WORKDIR="$(dirname "$(realpath "$0")")"
BRANCHES="release/1.7-stable release/1.8-stable"

cd "$WORKDIR"

for BRANCH in $BRANCHES; do
    FOLDER=$(basename "$BRANCH")
    echo "Processing branch $BRANCH..."

    rm -rf "$WORKDIR/$FOLDER"
    mkdir -p "$WORKDIR/$FOLDER"
    cd "$WORKDIR/$FOLDER"

    git init
    git remote add origin "$REPO"
    git config core.sparseCheckout true

    echo "specs/" > .git/info/sparse-checkout

    git fetch --depth 1 origin "$BRANCH"
    git checkout "$BRANCH"

    rm -rf .git
done

echo "All specs folders have been downloaded."
