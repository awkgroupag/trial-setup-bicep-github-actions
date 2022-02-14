var roleDefinitionResourceId_contr  = '/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'
var roleDefinitionResourceId_reader  = '/providers/Microsoft.Authorization/roleDefinitions/acdd72a7-3385-48ef-bd42-f606fba81ae7'
var principalId  = '1baeee5f-74b0-4a46-b90b-11f818c8095b'


resource testingStrg 'Microsoft.Storage/storageAccounts@2021-02-01' existing = {
  name: 'spstorage6w75eauwdifum'
}

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' existing = {
  name: 'user-man-id'
}

resource roleAssignment_manag 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  
  scope: managedIdentity
  name: guid(resourceGroup().id, managedIdentity.id, roleDefinitionResourceId_contr)
  properties: {
    roleDefinitionId: roleDefinitionResourceId_contr
    principalId: managedIdentity.properties.principalId
    principalType: 'ServicePrincipal'
    description: 'The user managed identity shall contribute to the storage account.'
  }
}


resource roleAssignment_storage 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' ={
  scope: testingStrg
  name: guid(testingStrg.id, principalId, roleDefinitionResourceId_reader)
  properties: {
    roleDefinitionId: roleDefinitionResourceId_reader
    principalId: principalId
    principalType: 'ServicePrincipal'
    description: 'I want the thing to read'
  }
}

resource roleAssignment_storage2 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' ={
  scope: testingStrg
  name: guid(testingStrg.id, principalId, roleDefinitionResourceId_contr)
  properties: {
    roleDefinitionId: roleDefinitionResourceId_contr
    principalId: principalId
    principalType: 'ServicePrincipal'
    description: 'I want the thing to contribute'
  }
}

