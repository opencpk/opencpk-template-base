#!/usr/bin/env bash

if [[ $CI == "true" ]]
  then
    # This is running in GitHub Actions
    GITHUB_REPO_NAME=$(basename "${GITHUB_REPOSITORY}")
    if [[ $(echo "${GITHUB_REPO_NAME}" |grep -c "cpk-template-") == 1 ]]; then
      # This is a template repo
      echo "SKIP=find-and-replace-strings" >> $GITHUB_ENV
    else
      # This is not a template repo
      echo "SKIP=none" >> $GITHUB_ENV
    fi
  else
    # This is running locally
    if [[ $(echo "${PWD}" |grep -c "cpk-template-") == 1 ]]; then
      # This is a template repo
      export "SKIP=find-and-replace-strings"
    else
      # This is not a template repo - delete the .pre-commit-template-skip-hooks.sh file
      rm -f .pre-commit-template-skip-hooks.sh
    fi
fi
