#!/bin/bash
# Script to convert .env-az JSON content to Azure CLI app settings string

json_file=".env-az"

# Read JSON and convert to --settings key=value pairs
settings=$(jq -r '.[] | "--settings \(.name)=\(.value)"' "$json_file" | tr '\n' ' ')

echo "$settings"

# Output example
# --settings GF_SERVER_DOMAIN= --settings GF_SERVER_ROOT_URL=https://%(domain)s --settings GF_PLUGINS_PREINSTALL_SYNC=volkovlabs-echarts-panel,volkovlabs-rss-datasource,volkovlabs-image-panel,marcusolsson-calendar-panel,marcusolsson-dynamictext-panel,volkovlabs-form-panel,volkovlabs-grapi-datasource,volkovlabs-rss-datasource,marcusolsson-static-datasource --settings GF_INSTALL_IMAGE_RENDERER_PLUGIN=true --settings GF_SECURITY_ADMIN_USER=ecoplus_admin --settings GF_SECURITY_ADMIN_PASSWORD= --settings GF_SECURITY_ADMIN_EMAIL=anderson.fontes.eco@gmail.com --settings GF_ANALYTICS_GOOGLE_ANALYTICS_UA_ID= --settings GF_DATABASE_TYPE=postgres --settings GF_DATABASE_HOST=ecoplus.postgres.database.azure.com:5432 --settings GF_DATABASE_NAME= --settings GF_DATABASE_USER= --settings GF_DATABASE_PASSWORD= --settings GF_DATABASE_SSL_MODE=require --settings GF_SMTP_ENABLED=true --settings GF_SMTP_HOST=smtp.gmail.com:587 --settings GF_SMTP_USER=ecoplus.notification@gmail.com --settings GF_SMTP_PASSWORD= --settings GF_SMTP_SKIP_VERIFY=true --settings GF_SMTP_FROM_ADDRESS=ecoplus.notification@gmail.com --settings GF_SMTP_FROM_NAME=Eco+ Notification --settings GF_AUTH_AZURE_ENABLED=false --settings GF_AUTH_AZURE_CLIENT_ID= --settings GF_AUTH_AZURE_CLIENT_SECRET= --settings GF_AUTH_AZURE_SCOPES=openid email profile --settings GF_AUTH_AZURE_AUTH_URL= --settings GF_AUTH_AZURE_TOKEN_URL=