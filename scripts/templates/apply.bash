#!/bin/bash

# Function to display usage information
usage() {
  echo "Usage: $0 --env <dev|prod> [--plan <plan_name>]"
  exit 1
}

# Initialize variables
env=""
plan=""

# Process command-line arguments
while [ "$#" -gt 0 ]; do
  case "$1" in
    --env)
      shift
      # Check if the environment argument is provided
      if [ -z "$1" ] || [ "${1:0:1}" == "-" ]; then
        usage
      fi
      env="$1"
      ;;
    --plan)
      shift
      # Check if the plan name argument is provided
      if [ -z "$1" ] || [ "${1:0:1}" == "-" ]; then
        usage
      fi
      plan="$1"
      ;;
    *)
      usage
      ;;
  esac
  shift
done

# Check if the environment is provided
if [ -z "$env" ]; then
  usage
fi

# Set the variable file based on the environment
var_file="../env/$env"

# Set the plan name or use the latest plan if not provided
plan_option=""
if [ -n "$plan" ]; then
  plan_option="-out=$plan"
else
  latest_plan=$(ls -1t *.tfplan 2>/dev/null | head -n 1)
  if [ -n "$latest_plan" ]; then
    plan_option="-out=$latest_plan"
  fi
fi

# Run Terraform apply command
terraform apply -var-file="$var_file" "$plan_option"
