#!/bin/bash

# Define the JSON file path
JSON_FILE="ParametricBox.json"

# Check if jq is installed
if ! command -v jq &> /dev/null
then
    echo "jq could not be found. Please install jq."
    exit 1
fi

# Extract and loop over the keys of parameterSets
jq -r '.parameterSets | keys[]' "$JSON_FILE" | while read -r key; do
    echo "Processing: $key"
    # Perform any additional operations on each key here
done