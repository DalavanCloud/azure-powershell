<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Returns the requested storage account.

.DESCRIPTION
    Returns the requested storage account.

.PARAMETER Summary
    Switch for wheter summary or detailed information is returned.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Storage.Admin.Models.StorageAccount.

.PARAMETER Skip
    Skip the first N items as specified by the parameter value.

.PARAMETER ResourceGroup
    Resource group name.

.PARAMETER ResourceId
    The resource id.

.PARAMETER FarmId
    Farm Id.

.PARAMETER Name
    Internal storage account ID, which is not visible to tenant.

.PARAMETER Top
    Return the top N items as specified by the parameter value. Applies after the -Skip parameter.

#>
function Get-AzsStorageAccount {
    [OutputType([Microsoft.AzureStack.Management.Storage.Admin.Models.StorageAccount])]
    [CmdletBinding(DefaultParameterSetName = 'StorageAccounts_Get')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'StorageAccounts_List')]
        [System.Boolean]
        $Summary,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_StorageAccounts_Get')]
        [Microsoft.AzureStack.Management.Storage.Admin.Models.StorageAccount]
        $InputObject,

        [Parameter(Mandatory = $false, ParameterSetName = 'StorageAccounts_List')]
        [int]
        $Skip = -1,

        [Parameter(Mandatory = $false, ParameterSetName = 'StorageAccounts_Get')]
        [Parameter(Mandatory = $false, ParameterSetName = 'StorageAccounts_List')]
        [System.String]
        $ResourceGroup,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_StorageAccounts_Get')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $true, ParameterSetName = 'StorageAccounts_Get')]
        [Parameter(Mandatory = $true, ParameterSetName = 'StorageAccounts_List')]
        [System.String]
        $FarmId,

        [Parameter(Mandatory = $true, ParameterSetName = 'StorageAccounts_Get')]
        [System.String]
        $Name,

        [Parameter(Mandatory = $false, ParameterSetName = 'StorageAccounts_List')]
        [int]
        $Top = -1
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


        if ('InputObject_StorageAccounts_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_StorageAccounts_Get' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}/providers/Microsoft.Storage.Admin/farms/{farmId}/storageaccounts/{accountId}'
            }

            if ('ResourceId_StorageAccounts_Get' -eq $PsCmdlet.ParameterSetName) {
                $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            } else {
                $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
            }
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params

            $ResourceGroup = $ArmResourceIdParameterValues['resourceGroup']
            $farmId = $ArmResourceIdParameterValues['farmId']
            $Name = $ArmResourceIdParameterValues['accountId']

        } elseif (-not $PSBoundParameters.Contains('ResourceGroup')) {
            $ResourceGroup = "System.$((Get-AzureRmLocation).Location)"
        }


        if ('StorageAccounts_List' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.StorageAccounts.ListWithHttpMessagesAsync($ResourceGroup, $FarmId, $Summary)
        } elseif ('StorageAccounts_Get' -eq $PsCmdlet.ParameterSetName -or 'InputObject_StorageAccounts_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_StorageAccounts_Get' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.StorageAccounts.GetWithHttpMessagesAsync($ResourceGroup, $FarmId, $Name)
        } else {
            Write-Verbose -Message 'Failed to map parameter set to operation method.'
            throw 'Module failed to find operation to execute.'
        }

        if ($TaskResult) {
            $GetTaskResult_params = @{
                TaskResult = $TaskResult
            }

            $TopInfo = @{
                'Count' = 0
                'Max'   = $Top
            }
            $GetTaskResult_params['TopInfo'] = $TopInfo
            $SkipInfo = @{
                'Count' = 0
                'Max'   = $Skip
            }
            $GetTaskResult_params['SkipInfo'] = $SkipInfo
            $PageResult = @{
                'Result' = $null
            }
            $GetTaskResult_params['PageResult'] = $PageResult
            $GetTaskResult_params['PageType'] = 'Microsoft.Rest.Azure.IPage[Microsoft.AzureStack.Management.Storage.Admin.Models.StorageAccount]' -as [Type]
            Get-TaskResult @GetTaskResult_params

            Write-Verbose -Message 'Flattening paged results.'
            while ($PageResult -and $PageResult.Result -and (Get-Member -InputObject $PageResult.Result -Name 'nextLink') -and $PageResult.Result.'nextLink' -and (($TopInfo -eq $null) -or ($TopInfo.Max -eq -1) -or ($TopInfo.Count -lt $TopInfo.Max))) {
                $PageResult.Result = $null
                Write-Debug -Message "Retrieving next page: $($PageResult.Result.'nextLink')"
                $TaskResult = $StorageAdminClient.StorageAccounts.ListNextWithHttpMessagesAsync($PageResult.Result.'nextLink')
                $GetTaskResult_params['TaskResult'] = $TaskResult
                $GetTaskResult_params['PageResult'] = $PageResult
                Get-TaskResult @GetTaskResult_params
            }
        }
    }

    End {
        if ($tracerObject) {
            $global:DebugPreference = $oldDebugPreference
            Unregister-PSSwaggerClientTracing -TracerObject $tracerObject
        }
    }
}
