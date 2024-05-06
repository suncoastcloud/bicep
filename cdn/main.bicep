@description('The Azure region into which the resources should be deployed.')
param location string = 'southcentralus'

@description('The name of the App Service.')
param appServiceName string = 'product-${uniqueString(resourceGroup().id)}'

@description('The name of the App Service plan SKU.')
param appServicePlanSkuName string = 'F1'

@description('Indicates whether a CDN should be deployed.')
param deployCdn bool = true

var appServicePlanName = 'product-launch-plan'

module app 'modules/app.bicep' = {
  name: appServiceName
  params: {
    location: location
    appServiceName: appServiceName
    appServicePlanName: appServicePlanName
    appServicePlanSKU: appServicePlanSkuName
  }
}

module cdn 'modules/cdn.bicep' = if (deployCdn) {
  name: 'product-launch-cdn'
  params: {
    httpsOnly: true
    originHostName: app.outputs.appServiceHostName
  }
}


@description('host name for the website')
output websiteHostName string = app.outputs.appServiceHostName
