#!/bin/bash

# Set variables for the Hugo content directory and GitHub repository.
CONTENT_DIR="./content/posts"

# Check if there are any posts available to edit
POSTS=($(ls "$CONTENT_DIR"/*.md))
if [ ${#POSTS[@]} -eq 0 ]; then
  echo "No posts found in $CONTENT_DIR."
  exit 1
fi

# Prompt to select the post to edit
POST_FILE=$(gum choose "${POSTS[@]}")
if [ -z "$POST_FILE" ]; then
  echo "No post selected."
  exit 1
fi

${EDITOR:-nvim} "$POST_FILE"

# Ask if the user wants to commit the changes
if gum confirm "Commit the changes?"; then
  git add "$POST_FILE"
  git commit -m "Edit post: $(basename "$POST_FILE" .md)"
  # Ask if the user wants to push the changes
  if gum confirm "Push changes to GitHub?"; then
    git push 
    echo "Changes pushed to GitHub."
  else
    echo "Changes committed locally but not pushed to GitHub."
  fi
else
  echo "Changes not committed."
fi

