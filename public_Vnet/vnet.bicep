var resourceTags  = {
  backupType: 'none'
  environmentName: 'development'
  maintenanceStatus: 'inactive'
  appFamily: 'xxxx'
  CostCenter: 'xxxxx'
  supportGroup: 'xxxx'
  maintenanceWindow: 'xxx'
 
  rightSize: 'optout'
}
var vNet = [
  {
    vNetName: 'ibVnet01'
    addressPrefix: '10.8.0.0/22'
    location: 'westus'
    subnetName01: 'ibVnet01_gatewaySubnet'
    subnetPrefix01: '10.8.0.0/27'
    subnetName02: 'ibVnet01_vmSubnet'
    subnetPrefix02: '10.8.0.64/26'
  }
  {
    vNetName: 'ibSpoke01'
    addressPrefix: '10.8.4.0/22'
    location: 'westus'
    subnetName01: 'ibSpoke01_gatewaySubnet'
    subnetPrefix01: '10.8.4.0/27'
    subnetName02: 'ibSpoke01_vmSubnet'
    subnetPrefix02: '10.8.4.64/26'
  }
  {
    vNetName: 'ibSpoke02'
    addressPrefix: '10.8.8.0/22'
    location: 'westus'
    subnetName01: 'ibSpoke02_gatewaySubnet'
    subnetPrefix01: '10.8.8.0/27'
    subnetName02: 'ibSpoke02_vmSubnet'
    subnetPrefix02: '10.8.8.64/26'
  }
]
var CloudflareDNS  = '1.1.1.1'
var googleDNS  = '8.8.8.8'

@batchSize(1)
resource vnet1_Resource 'Microsoft.Network/virtualNetworks@2018-11-01' = [ for v in vNet: {
  name: v.vNetName
  location: v.location
  tags: resourceTags
  properties: {
    addressSpace: {
      addressPrefixes: [
        v.addressPrefix
      ]
    }
    dhcpOptions: {
      dnsServers: [
        CloudflareDNS
        googleDNS
      ]
    }
    subnets: [
      {
        name: v.subnetName01
        properties: {
          addressPrefix: v.subnetPrefix01
        }
      }
      {
        name: v.subnetName02
        properties: {
          addressPrefix: v.subnetPrefix02
        }
      }
    ]
  }
}]

output vNetId array = [for v in vNet: {
  Vnetname: v.vNetName
}]
