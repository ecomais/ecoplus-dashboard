#!/bin/bash

# Usage:
# ./deploy_azure_webapp.sh -g resourceGroup -n appName -i containerImage [-l location] [-t tags]
# Example
# ./scripts/deploy_azure_webapp.sh \
#   -g myResourceGroup \
#   -n myAppName \
#   -i docker.io/ecomais/ecoplus-dashboard:latest \
#   -l eastus \
#   -t "env=production ecoplus-products=dashboard"

set -euo pipefail

# Default location
LOCATION="eastus"
# Path to the .env file
ENV_FILE=".env"

while getopts "g:n:i:l:t:" opt; do
  case $opt in
    g) RESOURCE_GROUP=$OPTARG ;;
    n) APP_NAME=$OPTARG ;;
    i) CONTAINER_IMAGE=$OPTARG ;;
    l) LOCATION=$OPTARG ;;
    t) TAGS=$OPTARG ;;
    *) echo "Usage: $0 -g resourceGroup -n appName -i containerImage [-l location] [-t tags]" >&2
       exit 1 ;;
  esac
done

if [ -z "$RESOURCE_GROUP" ] || [ -z "$APP_NAME" ] || [ -z "$CONTAINER_IMAGE" ]; then
  echo "Error: resourceGroup, appName, and containerImage are required." >&2
  echo "Usage: $0 -g resourceGroup -n appName -i containerImage [-l location] [-t tags]" >&2
  exit 1
fi

# Load app settings from conversion script
# APP_SETTINGS=$(bash ./scripts/convert_env_az_to_azure_cli.sh)
mapfile -t APP_SETTINGS < <(bash ./scripts/convert_env_az_to_azure_cli.sh "$ENV_FILE")

echo "Deploying Azure Web App for Containers..."
echo "Resource Group: $RESOURCE_GROUP"
echo "App Name: $APP_NAME"
echo "Container Image: $CONTAINER_IMAGE"
echo "Location: $LOCATION"
if ((${#APP_SETTINGS[@]} > 0)); then
  echo "Setting app settings -> ${APP_SETTINGS[@]}"
fi
if [ -n "$TAGS" ]; then
  echo "Tags: $TAGS"
fi


# # Check if resource group exists, create if not
# if ! az group show --name "$RESOURCE_GROUP" &> /dev/null; then
#   echo "Creating resource group $RESOURCE_GROUP in $LOCATION..."
#   az group create --name "$RESOURCE_GROUP" --location "$LOCATION"
# fi

# # Create or update App Service plan if needed
# if ! az appservice plan show --name "$APP_NAME-plan" --resource-group "$RESOURCE_GROUP" &> /dev/null; then
#   echo "Creating App Service plan $APP_NAME-plan..."
#   az appservice plan create --name "$APP_NAME-plan" --resource-group "$RESOURCE_GROUP" --sku B1 --is-linux
# fi

# # Check if app exists
# if az webapp show --resource-group "$RESOURCE_GROUP" --name "$APP_NAME" &> /dev/null; then
#   echo "Web App $APP_NAME exists. Updating configuration..."
# else
#   echo "Creating Web App $APP_NAME..."
#   az webapp create --resource-group "$RESOURCE_GROUP" --plan "$APP_NAME-plan" --name "$APP_NAME" --deployment-container-image-name "$CONTAINER_IMAGE"
# fi

# # Configure container settings
# echo "Configuring container settings..."
# az webapp config container set --name "$APP_NAME" --resource-group "$RESOURCE_GROUP" --docker-custom-image-name "$CONTAINER_IMAGE"

# # # Set app settings
# # if [ -n "$APP_SETTINGS" ]; then
# #   echo "Setting app settings..."
# #   az webapp config appsettings set --resource-group "$RESOURCE_GROUP" --name "$APP_NAME" $APP_SETTINGS
# # fi

# # Set app settings using the array
# if ((${#APP_SETTINGS_ARGS[@]} > 0)); then
#   echo "Setting app settings..."
#   az webapp config appsettings set \
#     --resource-group "$RESOURCE_GROUP" \
#     --name "$APP_NAME" \
#     "${APP_SETTINGS_ARGS[@]}"
# fi

# # Apply tags if provided
# if [ -n "$TAGS" ]; then
#   echo "Applying tags to the Web App..."
#   az resource tag --resource-group "$RESOURCE_GROUP" --resource-type "Microsoft.Web/sites" --name "$APP_NAME" --tags $TAGS
# fi

# echo "Restarting Web App..."
# az webapp restart --name "$APP_NAME" --resource-group "$RESOURCE_GROUP"

echo "Deployment complete."