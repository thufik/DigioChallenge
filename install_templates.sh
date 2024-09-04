#!/bin/bash

# Define variables
TEMPLATES_DIR="Templates"
XCODE_TEMPLATES_DIR="$HOME/Library/Developer/Xcode/Templates/File Templates"
PROJECT_TEMPLATES_DIR="$PWD/$TEMPLATES_DIR"

# Copy templates to Xcode templates directory
cp -R "$PROJECT_TEMPLATES_DIR" "$XCODE_TEMPLATES_DIR"

# Inform the user
echo "Custom Xcode file templates installed successfully!"
