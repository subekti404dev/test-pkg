#!/bin/bash
NAME_PKG="test-pkg"
LAST_TAG=$(git describe --tags --abbrev=0)
MESSAGES=$(git log $LAST_TAG..HEAD --no-merges --oneline --pretty=tformat:"%s")

IFS=$'\n' read -rd '' -a array <<<"$MESSAGES"

for index in "${!array[@]}"; do
   echo "---\n\"${NAME_PKG}\": patch\n---\n\n${array[index]}" > "./.changeset/update-${index}.md"
done
