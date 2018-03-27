<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Returns a list of destination shares that the system considers as best candidates for migration.

.DESCRIPTION
    Returns a list of destination shares that the system considers as best candidates for migration.

.PARAMETER ResourceGroupName
    Resource group name.

.PARAMETER SourceShareName
    Name of the share which holds containers to be migrated.

.PARAMETER FarmName
    Farm Id.

.EXAMPLE

	PS C:\> Get-AzsDestinationShare -ResourceGroupName "system.local" -FarmName f9b8e2e2-e4b4-44e0-9d92-6a848b1a5376 -SourceShareName "||SU1FileServer.azurestack.local|SU1_ObjStore"

    Get a list of destination shares that the system considers as best candidates for migration.

#>
function Get-AzsDestinationShare {
    [CmdletBinding(DefaultParameterSetName = 'ListDestinationShares')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'ListDestinationShares')]
        [System.String]
        $SourceShareName,

        [Parameter(Mandatory = $true, ParameterSetName = 'ListDestinationShares')]
        [System.String]
        $FarmName,

        [Parameter(Mandatory = $false, ParameterSetName = 'ListDestinationShares')]
        [System.String]
        $ResourceGroupName
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
            FullClientTypeName = 'Microsoft.AzureStack.Management.Storage.Admin.StorageAdminClient'
        }

        $GlobalParameterHashtable = @{}
        $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }

        $StorageAdminClient = New-ServiceClient @NewServiceClient_params

        if (-not $PSBoundParameters.ContainsKey('ResourceGroupName')) {
            $ResourceGroupName = "System.$((Get-AzureRmLocation).Location)"
        }

        if ('ListDestinationShares' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ListDestinationSharesWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.Containers.ListDestinationSharesWithHttpMessagesAsync($ResourceGroupName, $FarmName, $SourceShareName)
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
