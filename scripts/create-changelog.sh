#!/bin/bash
NAME_PKG="test-pkg"
LAST_TAG=$(git describe --tags --abbrev=0)

if [ -z "$LAST_TAG" ]; then
   MESSAGES=$(git log --no-merges --oneline --pretty=tformat:"%s")
   echo "MESSAGES: $MESSAGES"
else
   MESSAGES=$(git log $LAST_TAG..HEAD --no-merges --oneline --pretty=tformat:"%s")
   echo "MESSAGES: $MESSAGES"
fi

IFS=$'\n' read -rd '' -a array <<<"$MESSAGES"

for index in "${!array[@]}"; do
   cat >>./.changeset/update-${index}.md <<EOF
   ---
   "${NAME_PKG}": patch
   ---

   ${array[index]}
EOF
done
