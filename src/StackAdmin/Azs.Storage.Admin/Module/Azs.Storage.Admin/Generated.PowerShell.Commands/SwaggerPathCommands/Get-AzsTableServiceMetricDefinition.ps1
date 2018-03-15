<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Returns a list of metric definitions for table service.

.DESCRIPTION
    Returns a list of metric definitions for table service.

.PARAMETER Skip
    Skip the first N items as specified by the parameter value.

.PARAMETER ResourceGroupName
    Resource group name.

.PARAMETER FarmId
    Farm Id.

.PARAMETER Top
    Return the top N items as specified by the parameter value. Applies after the -Skip parameter.

.EXAMPLE
PS C:\> Get-AzsTableServiceMetricDefinition -ResourceGroupName "system.local" -FarmId f9b8e2e2-e4b4-44e0-9d92-6a848b1a5376

PrimaryAggregationType                                       Unit
----------------------                                       ----
Average                                                      Count
Average                                                      Count
Average                                                      Count
Total                                                        Count
Total                                                        Count
Total                                                        Count
Average                                                      CountPerSecond
Average                                                      Count
Average                                                      Count
Average                                                      Count
Average                                                      Count
Average                                                      Count
Average                                                      CountPerSecond
Average                                                      CountPerSecond
Average                                                      CountPerSecond
Average                                                      Count
Average                                                      Count
Average                                                      CountPerSecond
Average                                                      CountPerSecond
Average                                                      CountPerSecond
Average                                                      Count
Average                                                      Count

#>
function Get-AzsTableServiceMetricDefinition {
    [OutputType([Microsoft.AzureStack.Management.Storage.Admin.Models.MetricDefinition])]
    [CmdletBinding(DefaultParameterSetName = 'TableServices_ListMetricDefinitions')]
    param(
        [Parameter(Mandatory = $false, ParameterSetName = 'TableServices_ListMetricDefinitions')]
        [int]
        $Skip = -1,

        [Parameter(Mandatory = $false, ParameterSetName = 'TableServices_ListMetricDefinitions')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true, ParameterSetName = 'TableServices_ListMetricDefinitions')]
        [System.String]
        $FarmId,

        [Parameter(Mandatory = $false, ParameterSetName = 'TableServices_ListMetricDefinitions')]
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

        if (-not $PSBoundParameters.ContainsKey('ResourceGroupName')) {
            $ResourceGroupName = "System.$((Get-AzureRmLocation).Location)"
        }

        if ('TableServices_ListMetricDefinitions' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ListMetricDefinitionsWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.TableServices.ListMetricDefinitionsWithHttpMessagesAsync($ResourceGroupName, $FarmId)
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
            $GetTaskResult_params['PageType'] = 'Microsoft.Rest.Azure.IPage[Microsoft.AzureStack.Management.Storage.Admin.Models.MetricDefinition]' -as [Type]
            Get-TaskResult @GetTaskResult_params

            Write-Verbose -Message 'Flattening paged results.'
            while ($PageResult -and $PageResult.Result -and (Get-Member -InputObject $PageResult.Result -Name 'nextLink') -and $PageResult.Result.'nextLink' -and (($TopInfo -eq $null) -or ($TopInfo.Max -eq -1) -or ($TopInfo.Count -lt $TopInfo.Max))) {
                $PageResult.Result = $null
                Write-Debug -Message "Retrieving next page: $($PageResult.Result.'nextLink')"
                $TaskResult = $StorageAdminClient.TableServices.ListMetricDefinitionsNextWithHttpMessagesAsync($PageResult.Result.'nextLink')
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

