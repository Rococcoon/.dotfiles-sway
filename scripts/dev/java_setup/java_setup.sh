#!/bin/bash

# Configuration: Update this path to where your Java template lives
TEMPLATE_DIR="$HOME/.dotfiles-sway/scripts/dev/java_setup/java_template/"

# 1. Check if a project name was provided
if [ -z "$1" ]; then
    echo "Usage: ./java_setup.sh <project_name>"
    exit 1
fi

PROJECT_NAME=$1

# 2. Check if the source template exists
if [ ! -d "$TEMPLATE_DIR" ]; then
    echo "Error: Template directory $TEMPLATE_DIR not found."
    exit 1
fi

# 3. Check if the destination already exists to avoid overwriting
if [ -d "$PROJECT_NAME" ]; then
    echo "Error: Directory '$PROJECT_NAME' already exists."
    exit 1
fi

# 4. Copy the template to the new project name
echo "Creating project: $PROJECT_NAME..."
cp -r "$TEMPLATE_DIR" "$PROJECT_NAME"

# Update the project name in build.xml
sed -i "s/ProjectTemplate/$PROJECT_NAME/g" "$PROJECT_NAME/build.xml"

# Update only the first line of README.md to be the project name
sed -i "1s/.*/# $PROJECT_NAME/" "$PROJECT_NAME/README.md"

echo "Success! Project '$PROJECT_NAME' is ready."
cd "$PROJECT_NAME" && ls -R
