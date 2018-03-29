<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Undelete a deleted storage account.

.DESCRIPTION
    Undelete a deleted storage account.

.PARAMETER ResourceGroupName
    Resource group name.

.PARAMETER ResourceId
    The resource id.

.PARAMETER FarmName
    Farm Id.

.PARAMETER AccountId
    Internal storage account ID, which is not visible to tenant.

.PARAMETER Force
    Do not ask for confirmation.

.EXAMPLE

    PS C:\> Restore-AzsStorageAccount -FarmName "90987d65-eb60-42ae-b735-18bcd7ff69da" -AccountId "83fe9ac0-f1e7-433e-b04c-c61ae0712093"

    Undelete a deleted storage account.

#>
function Restore-AzsStorageAccount {
    [CmdletBinding(DefaultParameterSetName = 'Undelete', SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Undelete')]
        [System.String]
        $FarmName,

        [Parameter(Mandatory = $true, ParameterSetName = 'Undelete')]
        [System.String]
        $AccountId,

        [Parameter(Mandatory = $false, ParameterSetName = 'Undelete')]
        [ValidateLength(1, 90)]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId')]
        [Alias('id')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $false)]
        [switch]
        $Force
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

        if ('ResourceId' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}/providers/Microsoft.Storage.Admin/farms/{FarmName}/storageaccounts/{accountId}'
            }

            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
            $ResourceGroupName = $ArmResourceIdParameterValues['resourceGroup']

            $FarmName = $ArmResourceIdParameterValues['FarmName']
            $AccountId = $ArmResourceIdParameterValues['accountId']
        }

        # Should process
        if ($PSCmdlet.ShouldProcess("$AccountId" , "Restore the storage account")) {
            if (-not ($Force.IsPresent -or $PSCmdlet.ShouldContinue("Restore the storage account?", "Performing operation UndeleteWithHttpMessagesAsync on $AccountId."))) {
                return
            }
        }

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

        if ($ResourceGroupName -eq $null) {
            $ResourceGroupName = "System.$((Get-AzureRmLocation).Location)"
        }

        if ('Undelete' -eq $PsCmdlet.ParameterSetName -or 'ResourceId' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation UndeleteWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.StorageAccounts.UndeleteWithHttpMessagesAsync($ResourceGroupName, $FarmName, $AccountId)
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

