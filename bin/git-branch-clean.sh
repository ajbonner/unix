#!/usr/bin/env bash
set -e
set -o pipefail

if [ $# -lt 3 ]; then
  echo "Usage: $0 path/to/keep.txt git@somerepo.com/repo.git\n"
  exit 1
fi

IGNORE_FILE=$1
REPO=$2

if [ ! -r $IGNORE_FILE ]; then
  echo "keep.txt not found - exiting..."
  exit 1
fi

REMOTE_BRANCHES=$(git ls-remote $REPO | awk '{print $2}' | sed 's#refs/heads/##' | grep -v '^HEAD$')
KEEP_BRANCHES=$(cat $IGNORE_FILE)

for REMOTE_BRANCH in ${REMOTE_BRANCHES[@]}; do
  if [[ " ${KEEP_BRANCHES[@]} " =~ "${REMOTE_BRANCH}" ]]; then
    echo "Keeping $REMOTE_BRANCH"
  else
    echo "Deleting $REMOTE_BRANCH"
    git push origin :$REMOTE_BRANCH
  fi
done
