#!/bin/bash

# Stage changes
git add .

# Get the output of `git diff --staged`
diff_output=$(git diff --staged)

git commit -m "$diff_output"


git push origin master
