param Location string = 'eastus'

module virtualNetworkGateway './Templates/VirtualNetworkGateway.bicep' = {
  name: 'VirtualNetworkGateway'
  params: {
    enableBGP: false
    gatewayType: 'Vpn'
    location: Location
    PublicIpAddressName: 'pip-vng-sharedservices-001'
    rgName: resourceGroup().name 
    sku: 'Basic'
    SubnetName: 'GatewaySubnet'
    virtualNetworkGatewayName: 'vng-sharedservices-001'
    VirtualNetworkName: 'vnet-zementech-sharedservices-001'
    vpnType: 'RouteBased'
  }
}
module localNetworkGateway './Templates/LocalNetworkGateway.bicep' = {
  name: 'LocalNetworkGateway'
  params: {
    addressPrefixes: [
      '192.168.1.0/24'
      '192.168.10.0/24'
    ]
    gatewayIpAddress: '80.80.80.80'
    localNetworkGatewayName: 'lng-sharedservices-001'
    location: Location
  }
}

module connection './Templates/Connection.bicep' = {
  name: 'connection'
  params: {
    connectionName: 'cnt-sharedservices-001'
    connectionType: 'IPSec'
    enableBgp: false
    localNetworkGatewayId: localNetworkGateway.outputs.lngid
    location: Location
    sharedKey: 'dhsjkdlahldk23e2mda'
    virtualNetworkGatewayId: virtualNetworkGateway.outputs.vngid
  }
}
