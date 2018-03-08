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

.PARAMETER ShareName
    Name of the share which holds containers to be migrated.

.PARAMETER FarmId
    Farm Id.

.EXAMPLE
	PS C:\> Get-AzsDestinationShare -ResourceGroupName "system.local" -FarmId f9b8e2e2-e4b4-44e0-9d92-6a848b1a5376 -ShareName "||SU1FileServer.azurestack.local|SU1_ObjStore"

#>
function Get-AzsDestinationShare {
    [CmdletBinding(DefaultParameterSetName = 'Containers_ListDestinationShares')]
    param(
        [Parameter(Mandatory = $false, ParameterSetName = 'Containers_ListDestinationShares')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true, ParameterSetName = 'Containers_ListDestinationShares')]
        [System.String]
        $ShareName,

        [Parameter(Mandatory = $true, ParameterSetName = 'Containers_ListDestinationShares')]
        [System.String]
        $FarmId
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

        if(-not $PSBoundParameters.ContainsKey('ResourceGroupName')){
            $ResourceGroupName = "System.$((Get-AzureRmLocation).Location)"
        }

        if ('Containers_ListDestinationShares' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ListDestinationSharesWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.Containers.ListDestinationSharesWithHttpMessagesAsync($ResourceGroupName, $FarmId, $ShareName)
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