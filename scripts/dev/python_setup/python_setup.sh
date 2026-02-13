#!/bin/bash

LAB_NAME=$1

if [ -z "$LAB_NAME" ]; then
    echo "❌ Usage: ./init_lab.sh <lab_name>"
    exit 1
fi

echo "🏗️  Building full project factory for: $LAB_NAME"

# 1. CREATE THE PROJECT ROOT
mkdir -p "$LAB_NAME"
cd "$LAB_NAME"

# 2. CREATE DIRECTORY TREE
mkdir -p "src/$LAB_NAME/core"
mkdir -p "src/$LAB_NAME/models"
mkdir -p "src/$LAB_NAME/ui"
mkdir -p "src/$LAB_NAME/utils"
mkdir -p "tests"
mkdir -p "submission"
mkdir -p "scripts"

# Copy zip_lab.sh script to scripts directory
cp ~/.dotfiles-sway/scripts/dev/python_setup/template/scripts/zip_submission.sh scripts/

# 3. CREATE .gitignore (Arch/Python standard)
cat <<EOF > .gitignore
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/

# Environments
.venv/
env/
venv/
ENV/

# OS
.DS_Store
Thumbs.db
EOF

# 4. CREATE requirements.txt (Start empty)
touch requirements.txt

# 5. CREATE README.md (The Guide)
cat <<EOF > README.md
# 🐍 $LAB_NAME - High Level Programming

## 🛠️ Environment Setup
This project uses a virtual environment to keep your Arch system clean.

1. **Initialize/Sync:**
   \`\`\`bash
   python -m venv .venv
   source .venv/bin/activate
   pip install -e .
   \`\`\`

2. **Run Application:**
   \`\`\`bash
   python -m $LAB_NAME
   \`\`\`

## 📂 Structure
- \`src/$LAB_NAME/core\`: Main logic and controllers.
- \`src/$LAB_NAME/models\`: Data classes and structures.
- \`src/$LAB_NAME/utils\`: Helper functions.
- \`tests/\`: Unit tests.

## 📝 Dependencies
Add new libraries with \`pip install <name>\` then run \`pip freeze > requirements.txt\`.
EOF

# 6. CREATE pyproject.toml
cat <<EOF > pyproject.toml
[build-system]
requires = ["setuptools", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "$LAB_NAME"
version = "0.1.0"

[tool.setuptools.packages.find]
where = ["src"]
EOF

# 7. CREATE BOILERPLATE CODE & __init__.py files
touch "src/$LAB_NAME/"{__init__.py,core/__init__.py,models/__init__.py,ui/__init__.py,utils/__init__.py}

cat <<EOF > "src/$LAB_NAME/core/core.py"
def main_logic():
    print("✨ $LAB_NAME logic is executing...")
EOF

cat <<EOF > "src/$LAB_NAME/__main__.py"
from $LAB_NAME.core.core import main_logic

if __name__ == "__main__":
    print("--- Starting $LAB_NAME Application ---")
    main_logic()
EOF

# 8. AUTO-INITIALIZE VENV
python -m venv .venv
./.venv/bin/pip install -e .

echo "✅ $LAB_NAME is ready in $(pwd)"
echo "👉 Type: cd $LAB_NAME && source .venv/bin/activate"
