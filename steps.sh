# Variables
RESOURCE_GROUP="tour-of-heroes-ionic"
LOCATION="northeurope"
APPLICATION_NAME="tour-of-heroes-ionic"

# Create a resource group
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create Application Insights
az monitor app-insights component create \
--app $APPLICATION_NAME-insights --location $LOCATION \
--kind web -g $RESOURCE_GROUP \
--application-type web \
--retention-time 120

# Get Application Insights instrumentation key
APP_INSIGHTS_CONNECTION_STRING=$(az monitor app-insights component show \
--app $APPLICATION_NAME-insights -g $RESOURCE_GROUP \
--query "connectionString" -o tsv)
