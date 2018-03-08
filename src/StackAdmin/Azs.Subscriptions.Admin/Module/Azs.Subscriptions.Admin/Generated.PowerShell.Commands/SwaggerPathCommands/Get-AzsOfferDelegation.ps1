<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS


.DESCRIPTION
    Get the list of delegated offers.

.PARAMETER OfferName
    Name of an offer.

.PARAMETER Skip
    Skip the first N items as specified by the parameter value.

.PARAMETER ResourceId
    The resource id.

.PARAMETER Name
    Name of a offer delegation.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Subscriptions.Admin.Models.OfferDelegation.

.PARAMETER Top
    Return the top N items as specified by the parameter value. Applies after the -Skip parameter.

.EXAMPLE 
    PS C:\> Get-AzsOfferDelegation -OfferName offer1 -ResourceGroupName rg1


    SubscriptionId : c90173b1-de7a-4b1d-8600-b832b0e65946
    Id             : /subscriptions/0a823c45-d9e7-4812-a138-74e22213693a/resourceGroups/rg1/providers/Microsoft.Subscriptions.Admin/offers/offer1/offerDelegations/dlele
    Name           : offer1/dlele
    Type           : Microsoft.Subscriptions.Admin/offers/offerDelegations
    Location       : local
    Tags           :
#>
function Get-AzsOfferDelegation
{
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Admin.Models.OfferDelegation])]
    [CmdletBinding(DefaultParameterSetName='OfferDelegations_List')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'OfferDelegations_Get')]
        [string]
        $Name,

        [Parameter(Mandatory = $true, ParameterSetName = 'OfferDelegations_List')]
        [Parameter(Mandatory = $true, ParameterSetName = 'OfferDelegations_Get')]
        [System.String]
        $OfferName,

        [Parameter(Mandatory = $true, ParameterSetName = 'OfferDelegations_List')]
        [Parameter(Mandatory = $true, ParameterSetName = 'OfferDelegations_Get')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ResourceId_OfferDelegations_Get')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_OfferDelegations_Get')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $false, ParameterSetName = 'OfferDelegations_List')]
        [int]
        $Skip = -1,


        [Parameter(Mandatory = $false, ParameterSetName = 'OfferDelegations_List')]
        [int]
        $Top = -1
    )

    Begin
    {
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
        FullClientTypeName = 'Microsoft.AzureStack.Management.Subscriptions.Admin.SubscriptionsAdminClient'
    }

    $GlobalParameterHashtable = @{}
    $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

    $GlobalParameterHashtable['SubscriptionId'] = $null
    if($PSBoundParameters.ContainsKey('SubscriptionId')) {
        $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
    }

    $SubscriptionsAdminClient = New-ServiceClient @NewServiceClient_params

    $OfferDelegationName = $Name


    if('ResourceId_OfferDelegations_Get' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Subscriptions.Admin/offers/{offer}/offerDelegations/{offerDelegationName}'
        }

        if('ResourceId_OfferDelegations_Get' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']

        $offer = $ArmResourceIdParameterValues['offer']

        $offerDelegationName = $ArmResourceIdParameterValues['offerDelegationName']
    }


    if ('OfferDelegations_List' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.OfferDelegations.ListWithHttpMessagesAsync($ResourceGroupName, $OfferName)
    } elseif ('OfferDelegations_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_OfferDelegations_Get' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.OfferDelegations.GetWithHttpMessagesAsync($ResourceGroupName, $OfferName)
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
            'Max' = $Top
        }
        $GetTaskResult_params['TopInfo'] = $TopInfo
        $SkipInfo = @{
            'Count' = 0
            'Max' = $Skip
        }
        $GetTaskResult_params['SkipInfo'] = $SkipInfo
        $PageResult = @{
            'Result' = $null
        }
        $GetTaskResult_params['PageResult'] = $PageResult
        $GetTaskResult_params['PageType'] = 'Microsoft.Rest.Azure.IPage[Microsoft.AzureStack.Management.Subscriptions.Admin.Models.OfferDelegation]' -as [Type]
        Get-TaskResult @GetTaskResult_params

        Write-Verbose -Message 'Flattening paged results.'
        while ($PageResult -and $PageResult.Result -and (Get-Member -InputObject $PageResult.Result -Name 'nextLink') -and $PageResult.Result.'nextLink' -and (($TopInfo -eq $null) -or ($TopInfo.Max -eq -1) -or ($TopInfo.Count -lt $TopInfo.Max))) {
            $PageResult.Result = $null
            Write-Debug -Message "Retrieving next page: $($PageResult.Result.'nextLink')"
            $TaskResult = $SubscriptionsAdminClient.OfferDelegations.ListNextWithHttpMessagesAsync($PageResult.Result.'nextLink')
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
