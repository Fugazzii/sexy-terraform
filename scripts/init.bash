#!/bin/bash

# Function to display usage information
usage() {
  echo "Usage: $0 --name <directory_name>"
  exit 1
}

# Initialize variables
directory_name=""

# Process command-line arguments
while [ "$#" -gt 0 ]; do
  case "$1" in
    --name)
      shift
      # Check if the directory name argument is provided
      if [ -z "$1" ] || [ "${1:0:1}" == "-" ]; then
        usage
      fi
      directory_name="$1"
      ;;
    *)
      usage
      ;;
  esac
  shift
done

# Check if the directory name is provided
if [ -z "$directory_name" ]; then
  usage
fi

# Create directory and subdirectories
mkdir -p "projects/$directory_name/modules"
mkdir -p "projects/$directory_name/src"
mkdir -p "./projects/$directory_name/plans"
mkdir -p "./projects/$directory_name/env"

# Create env files
touch "projects/$directory_name/env/dev.tfvars"
touch "projects/$directory_name/env/prod.tfvars"

# Create source files
touch "projects/$directory_name/src/variables.tf"
touch "projects/$directory_name/src/main.tf"
touch "projects/$directory_name/src/outputs.tf"

# Create script files
cp "./scripts/templates/mod.bash" "projects/$directory_name/mod.bash"
cp "./scripts/templates/plan.bash" "projects/$directory_name/plan.bash"
cp "./scripts/templates/apply.bash" "projects/$directory_name/apply.bash"

echo "Directory structure and files created successfully in projects/$directory_name."