@description('Region where the resources will be deployed')
param location string = resourceGroup().location

@description('App Service name')
@secure()
param appServiceName string

@description('App Service Plan name')
param appServicePlanName string

@description('App Service Plan SKU')
param appServicePlanSKU string

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSKU
  }
  properties: {}
}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}

@description('default host name of the app service')
output appServiceHostName string = appServiceApp.properties.defaultHostName
