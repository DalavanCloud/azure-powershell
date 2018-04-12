<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Create or update a quota.

.DESCRIPTION
    Create or update a quota.

.PARAMETER Name
    Name of the network quota resource.

.PARAMETER Location
    Location of the resource.

.PARAMETER MaxNicsPerSubscription
    The maximum NICs allowed per subscription.

.PARAMETER MaxPublicIpsPerSubscription
    The maximum public IP addresses allowed per subscription.

.PARAMETER MaxVirtualNetworkGatewayConnectionsPerSubscription
    The maximum number of virtual network gateway connections allowed per subscription.

.PARAMETER MaxVnetsPerSubscription
    The maxium number of virtual networks allowed per subscription.

.PARAMETER MaxVirtualNetworkGatewaysPerSubscription
    The maximum number of virtual network gateways allowed per subscription.

.PARAMETER MaxSecurityGroupsPerSubscription
    The maximum number of security groups allowed per subscription.

.PARAMETER MaxLoadBalancersPerSubscription
    The maximum number of load balancers allowed per subscription.

.EXAMPLE

    PS C:\> New-AzsNetworkQuota -Name NetworkQuotaDefaultValues

    Create a new network quota with all the default values.
.EXAMPLE

    PS C:\> New-AzsNetworkQuota -Name NetworkQuota1 -MaxNicsPerSubscription 150 -MaxPublicIpsPerSubscription 150

    Create a new network quota with non default values for quota.
#>
function New-AzsNetworkQuota {
    [OutputType([Microsoft.AzureStack.Management.Network.Admin.Models.Quota])]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Name,

        [Parameter(Mandatory = $false)]
        [long]
        $MaxNicsPerSubscription = 100,

        [Parameter(Mandatory = $false)]
        [long]
        $MaxPublicIpsPerSubscription = 50,

        [Parameter(Mandatory = $false)]
        [long]
        $MaxVirtualNetworkGatewayConnectionsPerSubscription = 2,

        [Parameter(Mandatory = $false)]
        [long]
        $MaxVnetsPerSubscription = 50,

        [Parameter(Mandatory = $false)]
        [long]
        $MaxVirtualNetworkGatewaysPerSubscription = 1,

        [Parameter(Mandatory = $false)]
        [long]
        $MaxSecurityGroupsPerSubscription = 50,

        [Parameter(Mandatory = $false)]
        [long]
        $MaxLoadBalancersPerSubscription = 50,

        [Parameter(Mandatory = $false)]
        [System.String]
        $Location,

        [Parameter(Mandatory = $false, DontShow = $true)]
        [ValidateSet('None', 'Prepare', 'Commit', 'Abort')]
        [string]
        $MigrationPhase = 'Prepare',

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

        if (($Force.IsPresent -or $PSCmdlet.ShouldContinue("Create new network quota?", "Performing operation create network quota with $Name."))) {

            $NewServiceClient_params = @{
                FullClientTypeName = 'Microsoft.AzureStack.Management.Network.Admin.NetworkAdminClient'
            }

            $GlobalParameterHashtable = @{}
            $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

            $GlobalParameterHashtable['SubscriptionId'] = $null
            if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
                $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
            }

            $NetworkAdminClient = New-ServiceClient @NewServiceClient_params

            if ([String]::IsNullOrEmpty($Location)) {
                $Location = (Get-AzureRMLocation).Location
            }

            # Create object
            $flattenedParameters = @(
                'MaxNicsPerSubscription', 'MaxPublicIpsPerSubscription',
                'MaxVirtualNetworkGatewayConnectionsPerSubscription', 'MaxVnetsPerSubscription',
                'MaxVirtualNetworkGatewaysPerSubscription', 'MaxSecurityGroupsPerSubscription',
                'MaxLoadBalancersPerSubscription', 'MigrationPhase'
            )
            $utilityCmdParams = @{}
            $flattenedParameters | ForEach-Object {
                $utilityCmdParams[$_] = Get-Variable -Name $_ -ValueOnly
            }
            $Quota = New-QuotaObject @utilityCmdParams

            Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $NetworkAdminClient.'
            $TaskResult = $NetworkAdminClient.Quotas.CreateOrUpdateWithHttpMessagesAsync($Location, $Name, $Quota)

            if ($TaskResult) {
                $GetTaskResult_params = @{
                    TaskResult = $TaskResult
                }
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

