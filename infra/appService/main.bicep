@description('The name of the app service that you wish to create.')
param siteName string = 'bicep-app-service-container'

param dockerRegistryHost string
@secure()
param tokenId string

var servicePlanName = 'plan-${siteName}-001'

resource servicePlan 'Microsoft.Web/serverfarms@2016-09-01' = {
  kind: 'linux'
  name: servicePlanName
  location: resourceGroup().location
  properties: {
    name: servicePlanName
    reserved: true
  }
  sku: {
    tier: 'Standard'
    name: 'S1'
  }
  dependsOn: []
}

resource siteName_resource 'Microsoft.Web/sites@2016-08-01' = {
  name: siteName
  location: resourceGroup().location
  properties: {
    siteConfig: {
      appSettings: [
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: 'https://${dockerRegistryHost}'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: reference(tokenId).name
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: reference(tokenId).properties.credentials.passwords[0].value
        }
      ]
      linuxFxVersion: 'DOCKER|${dockerRegistryHost}/bicep-app-service-container:latest'
    }
    serverFarmId: servicePlan.id
  }
}
