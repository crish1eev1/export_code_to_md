# export_code_to_md

Small Bash script that exports all files with a given extension from a folder into **one Markdown file**.

## Usage

```bash
./export_code_to_md.sh <folder> <ext> [output.md]
```

Exemple:
```bash
./export_code_to_md.sh src py
```

## Notes
- Recursively scans the folder
- Ignores .git, node_modules, .venv, venv, __pycache__
- Auto-sets Markdown code language (py → python, js → javascript, etc.)
- Output defaults to <folder>_<ext>.md

