#!/bin/bash

# Script to parse deployment-manifest.yml and create bundles accordingly
# This script uses yq (YAML processor) to parse the manifest file

set -e

MANIFEST_FILE="deployment-manifest.yml"
VERSION_TAG="$1"

if [ -z "$VERSION_TAG" ]; then
    echo "Usage: $0 <version_tag>"
    exit 1
fi

# Check if yq is available, if not install it
if ! command -v yq &> /dev/null; then
    echo "Installing yq..."
    sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
    sudo chmod +x /usr/local/bin/yq
fi

echo "Parsing deployment manifest..."

# Function to create a bundle based on manifest configuration
create_bundle() {
    local bundle_type="$1"
    local bundle_name="$2"
    local temp_dir="temp-${bundle_type}-bundle"
    local include_common="$3"
    
    echo "Creating ${bundle_name} bundle..."
    
    # Create temporary directory
    mkdir -p "$temp_dir"
    
    # Include common components if specified
    if [ "$include_common" = "true" ]; then
        echo "Including common components..."
        
        # Copy common directories
        yq eval '.common.directories[]' "$MANIFEST_FILE" | while read -r dir; do
            if [ -d "$dir" ]; then
                echo "Copying common directory: $dir"
                cp -r "$dir" "$temp_dir/"
            fi
        done
        
        # Copy common files
        yq eval '.common.files[]' "$MANIFEST_FILE" | while read -r file; do
            if [ -f "$file" ]; then
                echo "Copying common file: $file"
                cp "$file" "$temp_dir/"
            fi
        done
    fi
    
    # Copy environment-specific components
    if [ "$bundle_type" != "common" ]; then
        echo "Including environment-specific components for $bundle_type..."
        
        # Copy environment directories
        yq eval ".environments.${bundle_type}.directories[]" "$MANIFEST_FILE" | while read -r dir; do
            if [ -d "$dir" ]; then
                echo "Copying environment directory: $dir"
                cp -r "$dir" "$temp_dir/"
            fi
        done
        
        # Copy environment files
        yq eval ".environments.${bundle_type}.files[]" "$MANIFEST_FILE" 2>/dev/null | while read -r file; do
            if [ -f "$file" ]; then
                echo "Copying environment file: $file"
                cp "$file" "$temp_dir/"
            fi
        done
    fi
    
    # Create the bundle
    cd "$temp_dir"
    zip -r "../${bundle_name}" .
    cd ..
    
    # Clean up
    rm -rf "$temp_dir"
    
    echo "Created: ${bundle_name}"
}

# Check if manifest exists
if [ ! -f "$MANIFEST_FILE" ]; then
    echo "Error: $MANIFEST_FILE not found!"
    exit 1
fi

# Read bundle settings
INCLUDE_COMMON=$(yq eval '.bundle_settings.include_common_in_environment_bundles' "$MANIFEST_FILE")
CREATE_COMMON=$(yq eval '.bundle_settings.create_common_bundle' "$MANIFEST_FILE")

echo "Bundle settings:"
echo "  Include common in environment bundles: $INCLUDE_COMMON"
echo "  Create separate common bundle: $CREATE_COMMON"

# Create common bundle if specified
if [ "$CREATE_COMMON" = "true" ]; then
    COMMON_BUNDLE_NAME=$(yq eval '.bundle_settings.naming.common_bundle' "$MANIFEST_FILE" | sed "s/{version}/$VERSION_TAG/g")
    create_bundle "common" "$COMMON_BUNDLE_NAME" "true"
fi

# Create environment-specific bundles
yq eval '.environments | keys | .[]' "$MANIFEST_FILE" | while read -r env; do
    if [ "$INCLUDE_COMMON" = "true" ]; then
        BUNDLE_NAME=$(yq eval '.bundle_settings.naming.full_bundle' "$MANIFEST_FILE" | sed "s/{environment}/$env/g" | sed "s/{version}/$VERSION_TAG/g")
    else
        BUNDLE_NAME=$(yq eval '.bundle_settings.naming.environment_bundle' "$MANIFEST_FILE" | sed "s/{environment}/$env/g" | sed "s/{version}/$VERSION_TAG/g")
    fi
    
    create_bundle "$env" "$BUNDLE_NAME" "$INCLUDE_COMMON"
done

echo "Bundle creation completed!"
