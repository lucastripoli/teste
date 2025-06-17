#!/bin/bash
# Script to install all modules from conda-requirements_2.txt (using specified versions)

REQ_FILE="$(dirname "$0")/conda-requirements_2.txt"

if [ ! -f "$REQ_FILE" ]; then
  echo "Requirements file not found: $REQ_FILE"
  exit 1
fi

while IFS= read -r line; do
  # Remove comments and empty lines
  [[ "$line" =~ ^#.*$ || -z "$line" ]] && continue
  # Remove trailing whitespace
  line=$(echo "$line" | xargs)
  # Skip if empty after trimming
  [ -z "$line" ] && continue
  echo "Installing $line ..."
  ./ingesta/Miniforge3_V3_7_3/bin/pip install "$line" --target ./ingesta/Miniforge3_V3.7.3_libs_with_version --upgrade
done < "$REQ_FILE"

echo "All packages processed."
