#!/bin/bash

# Check if the path argument is provided
if [ "$#" -eq 0 ]; then
  echo "Error: Please provide the output file name using --out or -o."
  exit 1
fi

# Extract the output file path from the command line arguments
while [ "$#" -gt 0 ]; do
  case "$1" in
    --out|-o)
      shift
      output_path="$1"
      ;;
    *)
      # Ignore other arguments for now
      ;;
  esac
  shift
done

# Check if the output path is provided
if [ -z "$output_path" ]; then
  echo "Error: Please provide the output file path using --out or -o."
  exit 1
fi

# Run Terraform commands
terraform init
terraform plan -out "./plans/$output_path"
