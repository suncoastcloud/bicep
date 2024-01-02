// this bicep file will create a new dns zone

// create a resource group to hold infra resources, if needed
// az group create --name scc-infra --location southcentralus

// create a deployment group that creates a dns zone in the resource group scc-infra
// az deployment group create --resource-group scc-infra --template-file dns-zone.bicep

@description('The name of the DNS zone to be created.  Must have at least 2 segments, e.g. hostname.org')
param zoneName string = 'bob.co'

resource zone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: zoneName
  location: 'global'
}

// resource record 'Microsoft.Network/dnsZones/A@2018-05-01' = {
//   parent: zone
//   name: recordName
//   properties: {
//     TTL: 3600
//     ARecords: [
//       {
//         ipv4Address: '1.2.3.4'
//       }
//       {
//         ipv4Address: '1.2.3.5'
//       }
//     ]
//   }
// }
