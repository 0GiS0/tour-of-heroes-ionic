# Variables
RESOURCE_GROUP="tour-of-heroes-ionic"
LOCATION="northeurope"
APPLICATION_NAME="tour-of-heroes-ionic"

# Create a resource group
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create a Log Analytics workspace
az monitor log-analytics workspace create \
--resource-group $RESOURCE_GROUP \
--workspace-name $APPLICATION_NAME-log-analytics \
--location $LOCATION

# Get Log Analytics workspace id
LOG_ANALYTICS_WORKSPACE_ID=$(az monitor log-analytics workspace show \
--resource-group $RESOURCE_GROUP \
--workspace-name $APPLICATION_NAME-log-analytics \
--query "id" -o tsv)


# Create Application Insights
az monitor app-insights component create \
--app $APPLICATION_NAME-insights --location $LOCATION \
--kind web -g $RESOURCE_GROUP \
--application-type web \
--workspace $LOG_ANALYTICS_WORKSPACE_ID

# Get Application Insights instrumentation key
APP_INSIGHTS_CONNECTION_STRING=$(az monitor app-insights component show \
--app $APPLICATION_NAME-insights -g $RESOURCE_GROUP \
--query "connectionString" -o tsv)

# Install Application Insights modules
npm install @microsoft/applicationinsights-web @microsoft/applicationinsights-angularplugin-js
