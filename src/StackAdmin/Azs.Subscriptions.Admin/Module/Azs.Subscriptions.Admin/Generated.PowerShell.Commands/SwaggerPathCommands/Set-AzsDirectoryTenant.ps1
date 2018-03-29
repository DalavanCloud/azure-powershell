<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Updates a directory tenant.

.DESCRIPTION
    Updates a directory tenant.

.PARAMETER TenantId
    Tenant unique identifier.

.PARAMETER ResourceGroupName
    The resource group the resource is located under.

.PARAMETER Location
    Location of the resource.

.PARAMETER ResourceId
    The resource id.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Subscriptions.Admin.Models.DirectoryTenant.

.PARAMETER Name
    Directory tenant name.

.EXAMPLE

    Set-AzsDirectoryTenant -ResourceGroupName rg1 -Name tenant1

    Update a directory tenant under a resource group.
#>
function Set-AzsDirectoryTenant
{
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Admin.Models.DirectoryTenant])]
    [CmdletBinding(DefaultParameterSetName='Update')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Update')]
        [System.String]
        $Name,

        [Parameter(Mandatory = $true, ParameterSetName = 'InputObject')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ResourceId')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Update')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Update')]
        [string]
        $TenantId,

        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Update')]
        [string]
        $Location,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject')]
        [Microsoft.AzureStack.Management.Subscriptions.Admin.Models.DirectoryTenant]
        $InputObject
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


    $flattenedParameters = @('TenantId', 'Location')
    $utilityCmdParams = @{}
    $flattenedParameters | ForEach-Object {
        if($PSBoundParameters.ContainsKey($_)) {
            $utilityCmdParams[$_] = $PSBoundParameters[$_]
        }
    }
    $NewTenant = New-DirectoryTenantObject @utilityCmdParams


    $Tenant = $Name

    if (-not $PSBoundParameters.ContainsKey('Location'))
    {
         $Location = (Get-AzureRMLocation).Location
         $PSBoundParameters.Add("Location", $Location)
    }

    if('InputObject' -eq $PsCmdlet.ParameterSetName -or 'ResourceId' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Subscriptions.Admin/directoryTenants/{tenant}'
        }

        if('ResourceId' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']

        $tenant = $ArmResourceIdParameterValues['tenant']
    }


    if ('Update' -eq $PsCmdlet.ParameterSetName -or 'InputObject' -eq $PsCmdlet.ParameterSetName -or 'ResourceId' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.DirectoryTenants.CreateOrUpdateWithHttpMessagesAsync($ResourceGroupName, $Tenant, $NewTenant)
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

