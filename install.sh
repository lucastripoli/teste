#!/bin/bash
# Script to install all modules from conda-requirements_2.txt (ignoring versions)

REQ_FILE="$(dirname "$0")/conda-requirements_2.txt"

if [ ! -f "$REQ_FILE" ]; then
  echo "Requirements file not found: $REQ_FILE"
  exit 1
fi

while IFS= read -r line; do
  # Remove comments and empty lines
  [[ "$line" =~ ^#.*$ || -z "$line" ]] && continue
  # Extract only the package name (before ==, >=, <=, >, <, ~, or whitespace)
  pkg=$(echo "$line" | sed 's/[<>=!~].*//;s/\s.*//')
  # Skip if empty after extraction
  [ -z "$pkg" ] && continue
  echo "Installing $pkg ..."
  ./ingesta/Miniforge3_V3_7_3/bin/pip install "$pkg" --target ./Miniforge3_V3.7.3_libs --upgrade
done < "$REQ_FILE"

echo "All packages processed."
