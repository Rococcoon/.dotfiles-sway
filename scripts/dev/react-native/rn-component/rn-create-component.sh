#!/bin/bash

# 1. Capture the full argument (e.g., src/components/SubmitButton)
FULL_PATH=$1

if [ -z "$FULL_PATH" ]; then
    echo "Usage: rn_create_component path/to/ComponentName"
    exit 1
fi

# 2. Extract the component name
COMPONENT_NAME=$(basename "$FULL_PATH")

# 3. Define paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/rn-component-template"
# Target directory where the component folder will live
TARGET_DIR="./$FULL_PATH"

# 4. Safety Checks
if [ ! -d "$TEMPLATE_DIR" ]; then
    echo "Error: Template directory not found at $TEMPLATE_DIR"
    exit 1
fi

if [ -d "$TARGET_DIR" ]; then
    echo "Error: Directory $TARGET_DIR already exists!"
    exit 1
fi

# 5. Create parent directories and copy the template folder
mkdir -p "$(dirname "$TARGET_DIR")"
cp -r "$TEMPLATE_DIR" "$TARGET_DIR"

# 6. Rename the files inside the new folder to match the component name
# Renames: rn-component-template.js -> SubmitButton.js
# Renames: rn-component-template.styles.js -> SubmitButton.styles.js
mv "$TARGET_DIR/rn-component-template.js" "$TARGET_DIR/$COMPONENT_NAME.js"
mv "$TARGET_DIR/rn-component-template.styles.js" "$TARGET_DIR/$COMPONENT_NAME.styles.js"

# 7. Perform the sed replacement in both files
# We use find to catch all files in the new directory and apply sed
find "$TARGET_DIR" -type f -exec sed -i "s|__COMPONENT_NAME__|$COMPONENT_NAME|g" {} +

# 8. Special Fix: Fix the import path in the main JS file
# Since the style file was renamed, we need to update the import line
sed -i "s|./rn-component-template.styles|./$COMPONENT_NAME.styles|g" "$TARGET_DIR/$COMPONENT_NAME.js"

echo "✅ Created component folder: $TARGET_DIR"
echo "   - $COMPONENT_NAME.js"
echo "   - $COMPONENT_NAME.styles.js"
