<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Delete an activation.

.DESCRIPTION
    Delete an activation.

.PARAMETER Name
    Name of the activation.

.PARAMETER ResourceId
    The resource id.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.AzureBridge.Admin.Models.ActivationResource.

#>
function Remove-AzsAzureBridgeRegistration {
    [OutputType([Microsoft.AzureStack.Management.AzureBridge.Admin.Models.ActivationResource])]
    [CmdletBinding(DefaultParameterSetName = 'Activations_Delete')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Activations_Delete')]
        [System.String]
        $Name,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_Activations_Delete')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $true, ParameterSetName = 'Activations_Delete')]
        [System.String]
        $ResourceGroup,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_Activations_Delete')]
        [Microsoft.AzureStack.Management.AzureBridge.Admin.Models.ActivationResource]
        $InputObject
    )

    Begin {
        Initialize-PSSwaggerDependencies -Azure
        $tracerObject = $null
        if (('continue' -eq $DebugPreference) -or ('inquire' -eq $DebugPreference)) {
            $oldDebugPreference = $global:DebugPreference
            $global:DebugPreference = "continue"
            $tracerObject = New-PSSwaggerClientTracing
            Register-PSSwaggerClientTracing -TracerObject $tracerObject
        }
    }

    Process {

        $ErrorActionPreference = 'Stop'

        $NewServiceClient_params = @{
            FullClientTypeName = 'Microsoft.AzureStack.Management.AzureBridge.Admin.AzureBridgeAdminClient'
        }

        $GlobalParameterHashtable = @{}
        $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }

        $AzureBridgeAdminClient = New-ServiceClient @NewServiceClient_params

        if ('InputObject_Activations_Delete' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Activations_Delete' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}/providers/Microsoft.AzureBridge.Admin/activations/{activationName}'
            }

            if ('ResourceId_Activations_Delete' -eq $PsCmdlet.ParameterSetName) {
                $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            } else {
                $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
            }
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params

            $resourceGroup = $ArmResourceIdParameterValues['resourceGroup']
            $Name = $ArmResourceIdParameterValues['activationName']
        }


        if ('Activations_Delete' -eq $PsCmdlet.ParameterSetName -or 'InputObject_Activations_Delete' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Activations_Delete' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation DeleteWithHttpMessagesAsync on $AzureBridgeAdminClient.'
            $TaskResult = $AzureBridgeAdminClient.Activations.DeleteWithHttpMessagesAsync($ResourceGroup, $Name)
        } else {
            Write-Verbose -Message 'Failed to map parameter set to operation method.'
            throw 'Module failed to find operation to execute.'
        }

        if ($TaskResult) {
            $GetTaskResult_params = @{
                TaskResult = $TaskResult
            }

            Get-TaskResult @GetTaskResult_params

        }
    }

    End {
        if ($tracerObject) {
            $global:DebugPreference = $oldDebugPreference
            Unregister-PSSwaggerClientTracing -TracerObject $tracerObject
        }
    }
}
