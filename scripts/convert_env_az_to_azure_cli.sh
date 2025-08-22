#!/bin/bash
set -euo pipefail

env_file="${1:-.env}"

# Function to convert .env file to Azure CLI --settings string
convert_env_file() {
  local env_file="$1"
  local line key value

  while IFS= read -r line || [ -n "$line" ]; do
    # strip CR for CRLF files
    line=${line%$'\r'}

    # skip blank lines and comments
    [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue

    # match first '=' only: key=rest-of-line
    if [[ "$line" =~ ^([^=[:space:]]+)[[:space:]]*=(.*)$ ]]; then
      key="${BASH_REMATCH[1]}"
      value="${BASH_REMATCH[2]}"

      # optional: trim surrounding quotes on value
      [[ "$value" =~ ^\"(.*)\"$ ]] && value="${BASH_REMATCH[1]}"
      [[ "$value" =~ ^\'(.*)\'$ ]] && value="${BASH_REMATCH[1]}"

      # keep the pair as a single argument to preserve spaces
      printf '%s\n' "--settings" "$key=$value"
    fi
  done < "$env_file"
}


# Usage:
convert_env_file ".env"