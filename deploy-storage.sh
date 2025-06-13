#!/bin/bash

# Azure Storage Static Website deployment script for MkDocs site
# Most cost-effective option for static website hosting

set -e  # Exit on any error

# Azure configuration
SUBSCRIPTION_ID="e7d8d5bc-2929-498e-90b5-cc730d72dd49"
RESOURCE_GROUP="ferranti-dev-ai"
LOCATION="swedencentral"

# Storage account configuration
STORAGE_ACCOUNT_NAME="faktionaidocs$(date +%s | tail -c 6)"  # Ensure unique name
STORAGE_SKU="Standard_LRS"  # Most cost-effective option
CONTAINER_NAME="\$web"  # Special container for static websites

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

# Upload files to $web container
echo "📤 Uploading static files..."
az storage blob upload-batch \
    --source $BUILD_DIR \
    --destination '$web' \
    --account-name $STORAGE_ACCOUNT_NAME \
    --account-key $STORAGE_KEY \
    --overwrite \
    --pattern "*"

# Set proper content types for common file extensions
echo "🔧 Setting content types..."
if az storage blob show --container-name '$web' --name index.html --account-name $STORAGE_ACCOUNT_NAME --account-key $STORAGE_KEY > /dev/null 2>&1; then
    az storage blob update \
        --container-name '$web' \
        --name index.html \
        --account-name $STORAGE_ACCOUNT_NAME \
        --account-key $STORAGE_KEY \
        --content-type "text/html"
fi

# Update CSS files
for css_file in $(az storage blob list --container-name '$web' --account-name $STORAGE_ACCOUNT_NAME --account-key $STORAGE_KEY --query "[?ends_with(name, '.css')].name" -o tsv); do
    echo "Setting content-type for CSS: $css_file"
    az storage blob update \
        --container-name '$web' \
        --name "$css_file" \
        --account-name $STORAGE_ACCOUNT_NAME \
        --account-key $STORAGE_KEY \
        --content-type "text/css"
done

# Update JS files
for js_file in $(az storage blob list --container-name '$web' --account-name $STORAGE_ACCOUNT_NAME --account-key $STORAGE_KEY --query "[?ends_with(name, '.js')].name" -o tsv); do
    echo "Setting content-type for JS: $js_file"
    az storage blob update \
        --container-name '$web' \
        --name "$js_file" \
        --account-name $STORAGE_ACCOUNT_NAME \
        --account-key $STORAGE_KEY \
        --content-type "application/javascript"
done

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