<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Create a subscription.

.DESCRIPTION
    Create a subscription.

.PARAMETER OfferId
    Identifier of the offer under the scope of a delegated provider.

.PARAMETER Id
    Fully qualified identifier.

.PARAMETER Type
    Type of resource.

.PARAMETER Tags
    List of key-value pairs.

.PARAMETER SubscriptionId
    Subscription identifier.

.PARAMETER State
    Subscription state.

.PARAMETER TenantId
    Directory tenant identifier.

.PARAMETER DisplayName
    Subscription name.

.PARAMETER Location
    Location where resource is location.

.EXAMPLE
	PS C:\> New-AzsSubscription -OfferId /delegatedProviders/default/offers/offer1

	DisplayName    : 
	Id             : /subscriptions/d387f779-85d8-40b6-8607-8306295ebff9
	OfferId        : /delegatedProviders/default/offers/offer1
	State          : Enabled
	SubscriptionId : d387f779-85d8-40b6-8607-8306295ebff9
	TenantId       : 1e64bce5-9f3b-4add-8be8-e550e05014d0

#>
function New-AzsSubscription
{
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Models.Subscription])]
    [CmdletBinding(DefaultParameterSetName='Subscriptions_CreateOrUpdate')]
    param(    
        [Parameter(Mandatory = $true, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [string]
        $OfferId,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [string]
        $DisplayName,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [string]
        $TenantId,

        [Parameter(Mandatory = $false, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [string]
        $SubscriptionId,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [ValidateSet('NotDefined', 'Enabled', 'Warned', 'PastDue', 'Disabled', 'Deleted')]
        [string]
        $State,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'Subscriptions_CreateOrUpdate')]
        [string]
        $Location
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
        FullClientTypeName = 'Microsoft.AzureStack.Management.Subscriptions.SubscriptionsManagementClient'
    }

    $GlobalParameterHashtable = @{}
    $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

    $SubscriptionsManagementClient = New-ServiceClient @NewServiceClient_params

    if (-not $PSBoundParameters.ContainsKey('State'))
    {
         $State = "Enabled"
         $PSBoundParameters.Add("State", $State)
    }
    
    if (-not ($PSBoundParameters.ContainsKey('SubscriptionId')))
    {
         $SubscriptionId = [Guid]::NewGuid().ToString()
         $PSBoundParameters.Add("SubscriptionId", $SubscriptionId)
    }

        
    $flattenedParameters = @('OfferId', 'Id', 'SubscriptionId', 'State', 'TenantId', 'DisplayName')
    $utilityCmdParams = @{}
    $flattenedParameters | ForEach-Object {
        if($PSBoundParameters.ContainsKey($_)) {
            $utilityCmdParams[$_] = $PSBoundParameters[$_]
        }
    }
    $NewSubscription = New-SubscriptionObject @utilityCmdParams



    if ('Subscriptions_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $SubscriptionsManagementClient.'
        $TaskResult = $SubscriptionsManagementClient.Subscriptions.CreateOrUpdateWithHttpMessagesAsync($SubscriptionId, $NewSubscription)
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

