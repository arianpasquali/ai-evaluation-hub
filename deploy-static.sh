#!/bin/bash

# Azure Static Web App deployment script for MkDocs site
# More efficient than Container Apps for static websites

set -e  # Exit on any error

# Azure configuration
SUBSCRIPTION_ID="e7d8d5bc-2929-498e-90b5-cc730d72dd49"
RESOURCE_GROUP="ferranti-dev-ai"
LOCATION="swedencentral"

# Static Web App configuration
STATIC_APP_NAME="faktion-ai-evaluation-docs"
SKU="Free"  # or "Standard" for custom domains and advanced features

# Build configuration
BUILD_DIR="site"  # MkDocs default output directory
SOURCE_DIR="docs"

echo "🚀 Starting deployment of MkDocs site to Azure Static Web Apps..."

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

# Check if Static Web App exists
echo "🔍 Checking if Static Web App exists..."
EXISTING_APP=$(az staticwebapp show --name $STATIC_APP_NAME --resource-group $RESOURCE_GROUP --query "name" -o tsv 2>/dev/null || echo "")

if [ -n "$EXISTING_APP" ]; then
    echo "📱 Updating existing Static Web App: $STATIC_APP_NAME"
    
    # Get deployment token
    DEPLOYMENT_TOKEN=$(az staticwebapp secrets list --name $STATIC_APP_NAME --resource-group $RESOURCE_GROUP --query "properties.apiKey" -o tsv)
    
else
    echo "🆕 Creating new Static Web App: $STATIC_APP_NAME"
    
    # Create new Static Web App
    az staticwebapp create \
        --name $STATIC_APP_NAME \
        --resource-group $RESOURCE_GROUP \
        --location $LOCATION \
        --sku $SKU \
        --source https://github.com/faktionbe/ai-evaluation-docs \
        --branch main \
        --app-location $SOURCE_DIR \
        --output-location $BUILD_DIR \
        --login-with-github
    
    # Get deployment token
    DEPLOYMENT_TOKEN=$(az staticwebapp secrets list --name $STATIC_APP_NAME --resource-group $RESOURCE_GROUP --query "properties.apiKey" -o tsv)
fi

# Deploy using Static Web Apps CLI (alternative method if GitHub integration isn't preferred)
echo "📤 Deploying static files..."

# Option 1: Direct deployment using Azure CLI extension
if command -v swa &> /dev/null; then
    echo "Using Static Web Apps CLI for deployment..."
    swa deploy --app-location . --output-location $BUILD_DIR --deployment-token $DEPLOYMENT_TOKEN
else
    echo "Installing Static Web Apps CLI..."
    npm install -g @azure/static-web-apps-cli
    swa deploy --app-location . --output-location $BUILD_DIR --deployment-token $DEPLOYMENT_TOKEN
fi

# Get the Static Web App URL
echo "🌐 Getting application URL..."
APP_URL=$(az staticwebapp show --name $STATIC_APP_NAME --resource-group $RESOURCE_GROUP --query "defaultHostname" -o tsv)

echo ""
echo "✅ Deployment completed successfully!"
echo "🌍 Your MkDocs site is now live at: https://$APP_URL"
echo ""
echo "📊 Additional information:"
echo "   - Resource Group: $RESOURCE_GROUP"
echo "   - Static Web App: $STATIC_APP_NAME"
echo "   - Location: $LOCATION"
echo "   - SKU: $SKU"
echo ""
echo "🔧 To update the site:"
echo "   1. Make changes to your docs"
echo "   2. Run: mkdocs build"
echo "   3. Run this script again"
echo ""
echo "💡 Pro tip: Enable GitHub Actions for automatic deployments on every commit!" 