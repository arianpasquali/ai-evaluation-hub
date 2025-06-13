#!/bin/bash

# Azure Storage Static Website deployment script for MkDocs site
# More robust version with better error handling

set -e  # Exit on any error

# Azure configuration
SUBSCRIPTION_ID="e7d8d5bc-2929-498e-90b5-cc730d72dd49"
RESOURCE_GROUP="ferranti-dev-ai"
LOCATION="swedencentral"

# Storage account configuration
STORAGE_ACCOUNT_NAME="faktionaidocs$(date +%s | tail -c 6)"  # Ensure unique name
STORAGE_SKU="Standard_LRS"  # Most cost-effective option

# Build configuration
BUILD_DIR="site"  # MkDocs default output directory
INDEX_DOCUMENT="index.html"
ERROR_DOCUMENT="404.html"

echo "🚀 Starting deployment of MkDocs site to Azure Storage Static Website..."

# Verify prerequisites
echo "📋 Checking prerequisites..."
if ! command -v az &> /dev/null; then
    echo "❌ Azure CLI not found. Please install: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli"
    exit 1
fi

if ! command -v mkdocs &> /dev/null; then
    echo "❌ MkDocs not found. Installing dependencies..."
    pip install -r requirements.txt
fi

# Login to Azure and set subscription
echo "🔐 Setting up Azure authentication..."
az account set --subscription $SUBSCRIPTION_ID

# Verify subscription and resource group
echo "✅ Verifying Azure resources..."
az account show --query "name" -o tsv
az group show --name $RESOURCE_GROUP --query "name" -o tsv

if [ $? -ne 0 ]; then
    echo "❌ Error: Resource group $RESOURCE_GROUP does not exist"
    exit 1
fi

# Build the MkDocs site
echo "🏗️  Building MkDocs site..."
mkdocs build --clean

if [ ! -d "$BUILD_DIR" ]; then
    echo "❌ Error: Build directory '$BUILD_DIR' not found after build"
    exit 1
fi

echo "✅ Build completed successfully"

# Check if storage account already exists (search for existing accounts with our prefix)
echo "🔍 Checking for existing storage accounts..."
EXISTING_STORAGE=$(az storage account list --resource-group $RESOURCE_GROUP --query "[?contains(name, 'faktionaidocs')].name" -o tsv | head -1)

if [ -n "$EXISTING_STORAGE" ]; then
    STORAGE_ACCOUNT_NAME=$EXISTING_STORAGE
    echo "📦 Using existing storage account: $STORAGE_ACCOUNT_NAME"
else
    echo "🆕 Creating new storage account: $STORAGE_ACCOUNT_NAME"
    
    # Create storage account
    az storage account create \
        --name $STORAGE_ACCOUNT_NAME \
        --resource-group $RESOURCE_GROUP \
        --location $LOCATION \
        --sku $STORAGE_SKU \
        --kind StorageV2 \
        --access-tier Hot
    
    echo "✅ Storage account created successfully"
fi

# Enable static website hosting
echo "🌐 Enabling static website hosting..."
az storage blob service-properties update \
    --account-name $STORAGE_ACCOUNT_NAME \
    --static-website \
    --index-document $INDEX_DOCUMENT \
    --404-document $ERROR_DOCUMENT

# Get storage account key
echo "🔑 Getting storage account key..."
STORAGE_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP --account-name $STORAGE_ACCOUNT_NAME --query "[0].value" -o tsv)

# Clear existing files in the $web container (optional)
echo "🧹 Clearing existing files..."
az storage blob delete-batch \
    --source '$web' \
    --account-name $STORAGE_ACCOUNT_NAME \
    --account-key $STORAGE_KEY \
    --quiet || echo "No existing files to delete"

# Upload files individually to handle potential path issues
echo "📤 Uploading static files..."
find "$BUILD_DIR" -type f | while read -r file; do
    # Get relative path from build directory
    relative_path="${file#$BUILD_DIR/}"
    
    echo "Uploading: $relative_path"
    
    # Determine content type based on file extension
    content_type="application/octet-stream"
    case "${file##*.}" in
        html) content_type="text/html" ;;
        css)  content_type="text/css" ;;
        js)   content_type="application/javascript" ;;
        json) content_type="application/json" ;;
        png)  content_type="image/png" ;;
        jpg|jpeg) content_type="image/jpeg" ;;
        svg)  content_type="image/svg+xml" ;;
        ico)  content_type="image/x-icon" ;;
        xml)  content_type="application/xml" ;;
        txt)  content_type="text/plain" ;;
        woff) content_type="font/woff" ;;
        woff2) content_type="font/woff2" ;;
    esac
    
    # Upload with correct content type
    az storage blob upload \
        --container-name '$web' \
        --file "$file" \
        --name "$relative_path" \
        --account-name $STORAGE_ACCOUNT_NAME \
        --account-key $STORAGE_KEY \
        --content-type "$content_type" \
        --overwrite \
        --no-progress
done

echo "✅ All files uploaded successfully"

# Get the website URL
echo "🌐 Getting website URL..."
WEBSITE_URL=$(az storage account show --name $STORAGE_ACCOUNT_NAME --resource-group $RESOURCE_GROUP --query "primaryEndpoints.web" -o tsv)

echo ""
echo "✅ Deployment completed successfully!"
echo "🌍 Your MkDocs site is now live at: $WEBSITE_URL"
echo ""
echo "📊 Additional information:"
echo "   - Resource Group: $RESOURCE_GROUP"
echo "   - Storage Account: $STORAGE_ACCOUNT_NAME"
echo "   - Location: $LOCATION"
echo "   - SKU: $STORAGE_SKU"
echo "   - Primary Endpoint: $WEBSITE_URL"
echo ""
echo "💰 Cost information:"
echo "   - Storage: ~\$0.02/GB/month"
echo "   - Bandwidth: ~\$0.09/GB (first 5GB free monthly)"
echo "   - Requests: ~\$0.004/10,000 requests"
echo ""
echo "🔧 To update the site:"
echo "   1. Make changes to your docs"
echo "   2. Run: mkdocs build"
echo "   3. Run this script again"
echo ""
echo "📝 Next steps:"
echo "   - Configure custom domain (optional)"
echo "   - Set up CDN for better performance (optional)"
echo "   - Configure HTTPS with custom domain" 