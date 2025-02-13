#!/bin/bash


# Variables
POST_DIR="content/posts"
DATETIME=$(date +"%Y-%m-%dT%H:%M:%S%z" | sed -E 's/([0-9]{2})([0-9]{2})$/\1:\2/')
DEFAULT_EDITOR="nvim"  # Replace 'nano' with your preferred text editor (e.g., 'vim', 'code')
DEFAULT_AUTHOR="Marcus Wathen"
# Check for Hugo installation
if ! command -v hugo &> /dev/null; then
    echo "Hugo is not installed. Please install Hugo first."
    exit 1
fi

# Ensure Gum is installed
if ! command -v gum &> /dev/null
then
    echo "Gum is required but not installed. Please install Gum: https://github.com/charmbracelet/gum"
    exit
fi

# Ensure Git is installed
if ! command -v git &> /dev/null
then
    echo "Git is required but not installed. Please install Git: https://git-scm.com/"
    exit
fi


# Use Gum to collect post details
TITLE=$(gum input --placeholder "Enter post title")
if [ -z "$TITLE" ]; then
    echo "Title cannot be empty. Exiting..."
    exit 1
fi
TAGS=$(gum input --placeholder "Enter post tags (comma-separated)")
CATEGORIES=$(gum input --placeholder "Enter post categories (comma-separated)")

# Convert title to slug (URL-friendly)
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr -s ' ' '-' | tr -cd '[:alnum:]-')

# Create file name
FILENAME="${POST_DIR}/${SLUG}.md"

# Use the default author if not provided

# Select draft status using Gum
echo "Select draft status:"
IS_DRAFT=$(gum choose "true" "false")
 if [ "$IS_DRAFT" == "Draft" ]; then
    DRAFT=true
else
    DRAFT=false
fi

AUTHOR=${AUTHOR:-$DEFAULT_AUTHOR}

# use default image storage
# DEFAULT_IMAGE_STORAGE="static/img"
# SELECT_CUSTOM_IMAGE=$(gum imput --placeholder "Enter image storage path")
# if [ -z "$SELECT_CUSTOM_IMAGE" ]; then
    # echo "Image storage path cannot be empty. Exiting..."
    # exit 1
# fi

# copy cover image from to static/img
# Select cover image location:
echo "Select cover image location:"
CHOOSE_IMAGE_LOCATION=$(gum choose "default" "custom" "none")
case $CHOOSE_IMAGE_LOCATION in
  "default")
    echo "Select cover image from default:"
    COVER_IMAGE=$(gum file static/img/)
    if [ -z "$COVER_IMAGE" ]; then
      echo "Cover image cannot be empty. Exiting..."
      exit 1
    fi
    ;;
  "custom")
    echo "Select cover image:$CHOOSE_IMAGE_LOCATION"
    COVER_IMAGE=$(gum file ~)
    if [ -z "$COVER_IMAGE" ]; then
      echo "Cover image cannot be empty. Exiting..."
      exit 1
    fi
    # ask if they want to copy the image to default
    echo "Do you want to copy the cover image to default?"
    echo "$COVER_IMAGE"
    COPY_TO_DEFAULT=$(gum input --placeholder "Yes/No")
    if [ "$COPY_TO_DEFAULT" == "yes" ]; then
        cp -p "${COVER_IMAGE}" ~/blog/blogsite/static/img/
        #COVER_IMAGE="default.png"
    fi
    ;;
  *)
    echo "Invalid choice. Please choose a valid option."
    exit 1
    ;;
esac



# Create the new post with Hugo
hugo new posts/$SLUG.md
# Use Gum to display a spinner while creating the post file
gum spin --spinner dot --title "Creating new post..." -- sleep 1

# Create front matter for the post
cat > "$FILENAME" <<EOF
---
title: "$TITLE"
date: $DATETIME
author: "$AUTHOR"
cover: img/${COVER_IMAGE##*/}
images:
  - img/${COVER_IMAGE##*/}
categories: [${CATEGORIES}]
tags: [${TAGS}]
draft: $DRAFT
---
EOF

# Notify user of post creation
gum style --border double --margin "1" --padding "1" --border-foreground "cyan" "New post created: $FILENAME"

# Open the post in the default editor with Gum visual feedback
gum confirm "Open the post in $DEFAULT_EDITOR?" && $DEFAULT_EDITOR "$FILENAME"
#
# Ask if the user wants to commit the new post to Git
if gum confirm "Commit and push the new post to Git?"; then
#
    # Stage the new post file
    gum spin --spinner dot --title "Staging post..." -- git add "$FILENAME"
    # 
    # Commit the post with a message
    COMMIT_MESSAGE="Add new post: $TITLE"
    gum spin --spinner dot --title "Committing post..." -- git commit -m "$COMMIT_MESSAGE"
    # 
    # Push the changes to the remote repository
    gum spin --spinner dot --title "Pushing to remote repository..." -- git push
#
    # Notify user of successful push
    gum style --border normal --margin "1" --padding "1" --border-foreground "green" "Post pushed to remote repository!"
else
    echo "Post was not committed or pushed."
fi

