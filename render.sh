#!/bin/bash

# Define the JSON file path
JSON_FILE="ParametricBox.json"

# Check if jq is installed
if ! command -v jq &> /dev/null
then
    echo "jq could not be found. Please install jq."
    exit 1
fi

ver=$(date +'%Y%m%d-%H')
echo $ver
# Extract and loop over the keys of parameterSets
jq -r '.parameterSets | keys[]' "$JSON_FILE" | while read -r key; do
    echo "Rendering: $key"
    # Perform any additional operations on each key here
    filename="$key-$ver.stl"
    openscad -o "$filename" ParametricBox.scad -p ParametricBox.json -p "$key"
done