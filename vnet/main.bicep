param myVirtualNetwork string = 'myVirtualNetwork'
param location string = resourceGroup().location


resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: myVirtualNetwork
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'subnet1'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
    ]
  }
}

param networkinterfaceName string = 'myNetworkInterface'

resource networkInterface 'Microsoft.Network/networkInterfaces@2023-09-01' = {
  name: networkinterfaceName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: networkinterfaceName
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetwork.properties.subnets[0].id
          }
        }
      }
    ]
  }
}

param routetableName string = 'myRouteTable'

resource routeTable 'Microsoft.Network/routeTables@2023-09-01' = {
  name: routetableName
  location: location
  properties: {
    routes: [
      {
        name: 'route1'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: networkInterface.properties.ipConfigurations[0].properties.privateIPAddress
        }
      }
    ]
  }
}


