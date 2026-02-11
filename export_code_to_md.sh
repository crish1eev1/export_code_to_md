#!/usr/bin/env bash
set -euo pipefail

FOLDER="${1:?folder required}"
EXT="${2:?extension required}"   # e.g., py or .py
OUT="${3:-"${FOLDER}_$(echo "${EXT#.}").md"}"

EXT="${EXT#.}"  # strip leading dot if present

# map some common extensions to md code fence languages
lang="$EXT"
case "$EXT" in
  py) lang="python" ;;
  js) lang="javascript" ;;
  ts) lang="typescript" ;;
  yml|yaml) lang="yaml" ;;
esac

# parent of folder to get headers like "folder/.../file.py"
ABS_FOLDER="$(realpath "$FOLDER")"
PARENT="$(dirname "$ABS_FOLDER")"

# default ignore dirs
IGNORE_DIRS="-path */.git -o -path */node_modules -o -path */.venv -o -path */venv -o -path */__pycache__"

: > "$OUT"
# shellcheck disable=SC2044
for f in $(find "$ABS_FOLDER" \( $IGNORE_DIRS \) -prune -o -type f -name "*.${EXT}" -print | sort); do
  rel="${f#"$PARENT"/}"
  echo "# $rel" >> "$OUT"
  echo >> "$OUT"
  echo '```'"$lang" >> "$OUT"
  cat "$f" >> "$OUT" || echo "<<failed to read>>" >> "$OUT"
  echo >> "$OUT"
  echo '```' >> "$OUT"
  echo >> "$OUT"
done

echo "Wrote to $OUT"
