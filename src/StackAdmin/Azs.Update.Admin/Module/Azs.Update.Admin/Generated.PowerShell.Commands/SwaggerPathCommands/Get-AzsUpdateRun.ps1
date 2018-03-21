<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Get the list of update runs.

.DESCRIPTION
    Get the list of update runs.  Instances of the UpdateRun objects returned can be piped to Restart-AzsUpdateRun, when applicable.

.PARAMETER Name
    Update run identifier.

.PARAMETER Location
    The name of the update location.

.PARAMETER Skip
    Skip the first N items as specified by the parameter value.

.PARAMETER Top
    Return the top N items as specified by the parameter value. Applies after the -Skip parameter.

.PARAMETER ResourceId
    The resource id.

.PARAMETER ResourceGroupName
    The resource group the resource is located under.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Update.Admin.Models.UpdateRun.

.PARAMETER UpdateName
    Name of the update.

.EXAMPLE
	PS C:\> Get-AzsUpdateRun -UpdateName Microsoft1.0.180302.1

	Progress    : Microsoft.AzureStack.Management.Update.Admin.Models.Step
	TimeStarted : 3/2/2018 5:25:22 PM
	Duration    : PT14H43M50.0644552S
	State       : Succeeded
	Id          : /subscriptions/23d66fd1-4743-42ff-b391-e29dc51d799e/resourceGroups/System.redmond/providers/Microsoft.Update.Admin/updateLocations/redmond/
				  updates/Microsoft1.0.180302.1/updateRuns/407d9b8f-debf-4058-b374-a94a1bb4de30
	Name        : 407d9b8f-debf-4058-b374-a94a1bb4de30
	Type        : Microsoft.Update.Admin/updateLocations/updates/updateRuns
	Location    : redmond
	Tags        : {}

#>
function Get-AzsUpdateRun {
    [OutputType([Microsoft.AzureStack.Management.Update.Admin.Models.UpdateRun])]
    [CmdletBinding(DefaultParameterSetName = 'UpdateRuns_List')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'UpdateRuns_Get')]
        [System.String]
        $Name,

        [Parameter(Mandatory = $true, ParameterSetName = 'UpdateRuns_List')]
        [Parameter(Mandatory = $true, ParameterSetName = 'UpdateRuns_Get')]
        [System.String]
        $UpdateName,

        [Parameter(Mandatory = $false, ParameterSetName = 'UpdateRuns_List')]
        [Parameter(Mandatory = $false, ParameterSetName = 'UpdateRuns_Get')]
        [System.String]
        $Location,

        [Parameter(Mandatory = $false, ParameterSetName = 'UpdateRuns_List')]
        [Parameter(Mandatory = $false, ParameterSetName = 'UpdateRuns_Get')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_UpdateRuns_Get')]
        [Alias('id')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $false, ParameterSetName = 'UpdateRuns_List')]
        [int]
        $Skip = -1,

        [Parameter(Mandatory = $false, ParameterSetName = 'UpdateRuns_List')]
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
            FullClientTypeName = 'Microsoft.AzureStack.Management.Update.Admin.UpdateAdminClient'
        }

        $GlobalParameterHashtable = @{}
        $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }

        if ( -not $PSBoundParameters.ContainsKey('Location')) {
            $Location = (Get-AzureRMLocation).Location
        }
        if (-not $PSBoundParameters.ContainsKey('ResourceGroupName')) {
            $ResourceGroupName = "System.$Location"
        }

        $UpdateAdminClient = New-ServiceClient @NewServiceClient_params

        if ('ResourceId_UpdateRuns_Get' -eq $PsCmdlet.ParameterSetName) {

            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}/providers/Microsoft.Update.Admin/updateLocations/{updateLocation}/updates/{update}/updateRuns/{runId}'
            }

            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params

            $ResourceGroupName = $ArmResourceIdParameterValues['resourceGroup']
            $Location = $ArmResourceIdParameterValues['updateLocation']
            $UpdateName = $ArmResourceIdParameterValues['update']
            $Name = $ArmResourceIdParameterValues['runId']
        } else {
            if (-not $PSBoundParameters.ContainsKey('Location')) {
                $Location = (Get-AzureRmLocation).Location
            }
            if (-not $PSBoundParameters.ContainsKey('ResourceGroupName')) {
                $ResourceGroupName = "System.$Location"
            }
        }

        $filterInfos = @(
            @{
                'Type'     = 'powershellWildcard'
                'Value'    = $Name
                'Property' = 'Name'
            })
        $applicableFilters = Get-ApplicableFilters -Filters $filterInfos
        if ($applicableFilters | Where-Object { $_.Strict }) {
            Write-Verbose -Message 'Performing server-side call ''Get-AzsUpdateRun -'''
            $serverSideCall_params = @{

            }

            $serverSideResults = Get-AzsUpdateRun @serverSideCall_params
            foreach ($serverSideResult in $serverSideResults) {
                $valid = $true
                foreach ($applicableFilter in $applicableFilters) {
                    if (-not (Test-FilteredResult -Result $serverSideResult -Filter $applicableFilter.Filter)) {
                        $valid = $false
                        break
                    }
                }

                if ($valid) {
                    $serverSideResult
                }
            }
            return
        }
        if ('UpdateRuns_List' -eq $PsCmdlet.ParameterSetName -or 'InputObject_UpdateRuns_Get' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $UpdateAdminClient.'
            $TaskResult = $UpdateAdminClient.UpdateRuns.ListWithHttpMessagesAsync($ResourceGroupName, $Location, $UpdateName)
        } elseif ('UpdateRuns_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_UpdateRuns_Get' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $UpdateAdminClient.'
            $TaskResult = $UpdateAdminClient.UpdateRuns.GetWithHttpMessagesAsync($ResourceGroupName, $Location, $UpdateName, $Name)
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
            $GetTaskResult_params['PageType'] = 'Microsoft.Rest.Azure.IPage[Microsoft.AzureStack.Management.Update.Admin.Models.UpdateRun]' -as [Type]
            Get-TaskResult @GetTaskResult_params

            Write-Verbose -Message 'Flattening paged results.'
            while ($PageResult -and $PageResult.Result -and (Get-Member -InputObject $PageResult.Result -Name 'nextLink') -and $PageResult.Result.'nextLink' -and (($TopInfo -eq $null) -or ($TopInfo.Max -eq -1) -or ($TopInfo.Count -lt $TopInfo.Max))) {
                $PageResult.Result = $null
                Write-Debug -Message "Retrieving next page: $($PageResult.Result.'nextLink')"
                $TaskResult = $UpdateAdminClient.UpdateRuns.ListNextWithHttpMessagesAsync($PageResult.Result.'nextLink')
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
