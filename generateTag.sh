#!/bin/bash

current_major=${1:-1}

tags=$(git tag --list)

latest_tag=$(echo "$tags" | grep -E '^v?[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -n 1)

if [ -n "$latest_tag" ]; then

    version=$(echo "$latest_tag" | sed 's/^v//')

    IFS='.-' read -r major minor patch <<< "$version"

    if [[ "$current_major" == "$major" ]]; then
        new_minor=$((minor+1))
        new_version="v$major.$new_minor.0"
        echo "$new_version"
    else
        echo "v$current_major.0.0"
    fi

else

    echo "v$current_major.0.0"

fi