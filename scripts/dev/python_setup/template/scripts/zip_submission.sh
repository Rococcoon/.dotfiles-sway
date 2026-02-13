#!/bin/bash

# Use the folder name as the lab name
LAB_NAME=$(basename "$PWD")
ZIP_NAME="${LAB_NAME}_submission.zip"

echo "🤐 Zipping up $LAB_NAME for submission..."

# Check if zip is installed
if ! command -v zip &> /dev/null; then
    echo "❌ Error: 'zip' is not installed. Run 'sudo pacman -S zip' first."
    exit 1
fi

# Clean up any old zip files first
rm -f "$ZIP_NAME"

# The Magic Command:
# -r: recursive
# -x: exclude these patterns
zip -r "$ZIP_NAME" . \
    -x "*.venv/*" \
    -x "*/__pycache__/*" \
    -x "*.egg-info/*" \
    -x ".git/*" \
    -x ".pytest_cache/*" \
    -x "dist/*" \
    -x "build/*"

echo "-----------------------------------"
echo "✅ Done! Created: $ZIP_NAME"
echo "📂 Contents of the zip:"
unzip -l "$ZIP_NAME"
