#!/bin/bash

scadfile="$1"
tag="$2"

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
    echo "Rendering: $key"
    # Perform any additional operations on each key here
    filename="$key-$tag.stl"
    openscad -o "$filename" $scadfile -p "$JSON_FILE" -P "$key"
done