#!/bin/bash

# 1. Check for project name
if [ -z "$1" ]; then
  echo "Usage: rn_project_setup <ProjectName>"
  exit 1
fi

PROJECT_NAME=$1
# SCRIPT_DIR is .../react-native/
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# TEMPLATE_PATH is .../react-native/rn-template-files/
TEMPLATE_PATH="$SCRIPT_DIR/rn-template-files"

# VALIDATION: Ensure the template folder actually exists
if [ ! -d "$TEMPLATE_PATH/src" ]; then
  echo "❌ Error: Could not find template source at $TEMPLATE_PATH/src"
  exit 1
fi

# 2. Initialize Expo
echo "🚀 Initializing Expo project: $PROJECT_NAME..."
npx create-expo-app@latest "$PROJECT_NAME" --template blank --no-install

# 3. Enter project directory
cd "$PROJECT_NAME" || { echo "❌ Failed to enter $PROJECT_NAME"; exit 1; }

# 4. Wipe default Expo files to clear the way
# We remove everything that your template is about to replace
rm -rf App.js index.js README.md jsconfig.json app.json

# 5. Copy everything from rn-template-files
echo "📂 Applying custom template from $TEMPLATE_PATH..."
# Using cp -R to grab everything inside rn-template-files
cp -Rv "$TEMPLATE_PATH"/* .

# 6. Global find-and-replace for the project name
echo "📝 Updating placeholders to $PROJECT_NAME..."
# Handles macOS (empty string) and Linux sed syntax
find . -type f -not -path '*/.*' -not -path '*/node_modules/*' -exec sed -i '' "s/__PROJECTNAME__/$PROJECT_NAME/g" {} + 2>/dev/null || \
find . -type f -not -path '*/.*' -not -path '*/node_modules/*' -exec sed -i "s/__PROJECTNAME__/$PROJECT_NAME/g" {} +

# 7. Install dependencies
echo "⚙️  Installing dependencies..."
npm install
npm install --save-dev @types/react @types/react-native

echo "✨ Project $PROJECT_NAME is ready for action!"
