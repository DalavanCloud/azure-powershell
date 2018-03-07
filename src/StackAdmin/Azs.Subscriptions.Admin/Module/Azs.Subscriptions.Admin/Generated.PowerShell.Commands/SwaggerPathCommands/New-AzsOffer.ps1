<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Creates a new offer.

.DESCRIPTION
    Create or update the offer.

.PARAMETER Name
    Name of an offer.

.PARAMETER MaxSubscriptionsPerAccount
    Maximum subscriptions per account.

.PARAMETER DisplayName
    Display name of offer.

.PARAMETER BasePlanIds
    Identifiers of the base plans that become available to the tenant immediately when a tenant subscribes to the offer.

.PARAMETER Description
    Description of offer.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER ExternalReferenceId
    External reference identifier.

.PARAMETER State
    Offer accessibility state.

.PARAMETER Location
    Location of the resource.

.PARAMETER SubscriptionCount
    Current subscription count.

.PARAMETER AddonPlanDefinition
    References to add-on plans that a tenant can optionally acquire as a part of the offer.

.EXAMPLE
    PS C:\> New-AzsOffer -Name offer1 -ResourceGroupName rg1 -State Public -DisplayName "offer1" -BasePlanIds "/subscriptions/0a823c45-d9e7-4812-a138-74e22213693a/resourceGroups/rg1/providers/Microsoft.Subscriptions.Admin/plans/plan1"                            

    OfferName                  : offer1
    DisplayName                : offer1
    Description                : 
    State                      : Public
    SubscriptionCount          : 1
    MaxSubscriptionsPerAccount : 0
    BasePlanIds                : {/subscriptions/0a823c45-d9e7-4812-a138-74e22213693a/resourceGroups/rg1/providers/Microsoft.Subscriptions.Admin/plans/plan1}
    AddonPlanDefinition        : 
    Id                         : /subscriptions/0a823c45-d9e7-4812-a138-74e22213693a/resourceGroups/rg1/providers/Microsoft.Subscriptions.Admin/offers/offer1
    Name                       : offer1
    Type                       : Microsoft.Subscriptions.Admin/offers
    Location                   : local
    Tags                       : 
    
#>
function New-AzsOffer
{
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Offer])]
    [CmdletBinding(DefaultParameterSetName='Offers_CreateOrUpdate')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Offers_CreateOrUpdate')]
        [System.String]
        $Name,

        [Parameter(Mandatory = $true, ParameterSetName = 'Offers_CreateOrUpdate')]
        [string]
        $DisplayName,

        [Parameter(Mandatory = $true, ParameterSetName = 'Offers_CreateOrUpdate')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $false, ParameterSetName = 'Offers_CreateOrUpdate')]
        [string[]]
        $BasePlanIds,

        [Parameter(Mandatory = $false, ParameterSetName = 'Offers_CreateOrUpdate')]
        [string]
        $Description,

        [Parameter(Mandatory = $false, ParameterSetName = 'Offers_CreateOrUpdate')]
        [string]
        $ExternalReferenceId,

        [Parameter(Mandatory = $false, ParameterSetName = 'Offers_CreateOrUpdate')]
        [ValidateSet('Private', 'Public', 'Decommissioned')]
        [string]
        $State,

        [Parameter(Mandatory = $false, ParameterSetName = 'Offers_CreateOrUpdate')]
        [string]
        $Location,

        [Parameter(Mandatory = $false, ParameterSetName = 'Offers_CreateOrUpdate')]
        [int64]
        $MaxSubscriptionsPerAccount,

        [Parameter(Mandatory = $false, ParameterSetName = 'Offers_CreateOrUpdate')]
        [int64]
        $SubscriptionCount,

        [Parameter(Mandatory = $false, ParameterSetName = 'Offers_CreateOrUpdate')]
        [Microsoft.AzureStack.Management.Subscriptions.Admin.Models.AddonPlanDefinition[]]
        $AddonPlanDefinition
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

    if (-not $PSBoundParameters.ContainsKey('Location'))
    {
         $Location = (Get-AzureRMLocation).Location
         $PSBoundParameters.Add("Location", $Location)
    }
    
    if (-not $PSBoundParameters.ContainsKey('State'))
    {
         $State = "Private"
         $PSBoundParameters.Add("State", $Location)
    }
        
    $flattenedParameters = @('MaxSubscriptionsPerAccount', 'BasePlanIds', 'DisplayName', 'Name', 'Description', 'ExternalReferenceId', 'State', 'Location', 'SubscriptionCount', 'AddonPlanDefinition')
    $utilityCmdParams = @{}
    $flattenedParameters | ForEach-Object {
        if($PSBoundParameters.ContainsKey($_)) {
            $utilityCmdParams[$_] = $PSBoundParameters[$_]
        }
    }

    $NewOffer = New-OfferObject @utilityCmdParams

    if ('Offers_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.Offers.CreateOrUpdateWithHttpMessagesAsync($ResourceGroupName, $Name, $NewOffer)
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
