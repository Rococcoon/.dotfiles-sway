# 🐍 template - High Level Programming

## 🛠️ Environment Setup
This project uses a virtual environment to keep your Arch system clean.

1. **Initialize/Sync:**
   ```bash
   python -m venv .venv
   source .venv/bin/activate
   pip install -e .
   ```

2. **Run Application:**
   ```bash
   python -m template
   ```

## 📂 Structure
- `src/template/core`: Main logic and controllers.
- `src/template/models`: Data classes and structures.
- `src/template/utils`: Helper functions.
- `tests/`: Unit tests.

## 📝 Dependencies
Add new libraries with `pip install <name>` then run `pip freeze > requirements.txt`.
