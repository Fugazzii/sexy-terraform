#!/bin/bash

# Function to display usage information
usage() {
  echo "Usage: $0 --name <module_name>"
  exit 1
}

# Initialize variables
module_name=""

# Process command-line arguments
while [ "$#" -gt 0 ]; do
  case "$1" in
    --name|-n)
      shift
      # Check if the module name argument is provided
      if [ -z "$1" ] || [ "${1:0:1}" == "-" ]; then
        usage
      fi
      module_name="$1"
      ;;
    *)
      usage
      ;;
  esac
  shift
done

# Check if the module name is provided
if [ -z "$module_name" ]; then
  usage
fi

# Create module directory and files
mkdir -p "../modules/$module_name"
touch "../modules/$module_name/main.tf" "../modules/$module_name/variables.tf" "../modules/$module_name/outputs.tf"

echo "Module structure and files created successfully in modules/$module_name."
