<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Create an IP pool.  Once created an IP pool cannot be deleted.

.DESCRIPTION
    Create an IP pool.  Once created an IP pool cannot be deleted.

.PARAMETER Name
    IP pool name.

.PARAMETER AddressPrefix
    The address prefix.

.PARAMETER StartIpAddress
    The starting IP address.

.PARAMETER EndIpAddress
    The ending IP address.

.PARAMETER Location
    The region where the resource is located.

.PARAMETER ResourceGroupName
    Resource group in which the resource provider has been registered.

.PARAMETER Tags
    List of key-value pairs.

#>
function New-AzsIpPool {
    [OutputType([Microsoft.AzureStack.Management.Fabric.Admin.Models.ProvisioningState])]
    [CmdletBinding(DefaultParameterSetName = 'Create')]
    param(
        [Parameter(Mandatory = $false)]
        [string]
        $Name,

        [Parameter(Mandatory = $false)]
        [string]
        $AddressPrefix,

        [Parameter(Mandatory = $false)]
        [string]
        $StartIpAddress,

        [Parameter(Mandatory = $false)]
        [string]
        $EndIpAddress,

        [Parameter(Mandatory = $false)]
        [string]
        $Location,

        [Parameter(Mandatory = $false)]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $false)]
        [System.Collections.Generic.Dictionary[[string], [string]]]
        $Tags,

        [Parameter(Mandatory = $false)]
        [switch]
        $AsJob
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
            FullClientTypeName = 'Microsoft.AzureStack.Management.Fabric.Admin.FabricAdminClient'
        }

        $GlobalParameterHashtable = @{}
        $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }

        $FabricAdminClient = New-ServiceClient @NewServiceClient_params

        if (-not $PSBoundParameters.ContainsKey('Location')) {
            $Location = (Get-AzureRMLocation).Location
        }
        if (-not $PSBoundParameters.ContainsKey('ResourceGroupName')) {
            $ResourceGroupName = "System.$Location"
        }

        $flattenedParameters = @('NumberOfIpAddressesInTransition', 'StartIpAddress', 'Tags', 'AddressPrefix', 'NumberOfIpAddresses', 'Location', 'EndIpAddress', 'NumberOfAllocatedIpAddresses')
        $utilityCmdParams = @{}
        $flattenedParameters | ForEach-Object {
            if ($PSBoundParameters.ContainsKey($_)) {
                $utilityCmdParams[$_] = $PSBoundParameters[$_]
            }
        }
        $Pool = New-IpPoolObject @utilityCmdParams

        if ('Create' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $FabricAdminClient.'
            $TaskResult = $FabricAdminClient.IpPools.CreateOrUpdateWithHttpMessagesAsync($ResourceGroupName, $Location, $Name, $Pool)
        } else {
            Write-Verbose -Message 'Failed to map parameter set to operation method.'
            throw 'Module failed to find operation to execute.'
        }

        Write-Verbose -Message "Waiting for the operation to complete."

        $PSSwaggerJobScriptBlock = {
            [CmdletBinding()]
            param(
                [Parameter(Mandatory = $true)]
                [System.Threading.Tasks.Task]
                $TaskResult,

                [Parameter(Mandatory = $true)]
                [string]
                $TaskHelperFilePath
            )
            if ($TaskResult) {
                . $TaskHelperFilePath
                $GetTaskResult_params = @{
                    TaskResult = $TaskResult
                }

                Get-TaskResult @GetTaskResult_params

            }
        }

        $PSCommonParameters = Get-PSCommonParameter -CallerPSBoundParameters $PSBoundParameters
        $TaskHelperFilePath = Join-Path -Path $ExecutionContext.SessionState.Module.ModuleBase -ChildPath 'Get-TaskResult.ps1'
        if ($AsJob) {
            $ScriptBlockParameters = New-Object -TypeName 'System.Collections.Generic.Dictionary[string,object]'
            $ScriptBlockParameters['TaskResult'] = $TaskResult
            $ScriptBlockParameters['AsJob'] = $AsJob
            $ScriptBlockParameters['TaskHelperFilePath'] = $TaskHelperFilePath
            $PSCommonParameters.GetEnumerator() | ForEach-Object { $ScriptBlockParameters[$_.Name] = $_.Value }

            Start-PSSwaggerJobHelper -ScriptBlock $PSSwaggerJobScriptBlock `
                -CallerPSBoundParameters $ScriptBlockParameters `
                -CallerPSCmdlet $PSCmdlet `
                @PSCommonParameters
        } else {
            Invoke-Command -ScriptBlock $PSSwaggerJobScriptBlock `
                -ArgumentList $TaskResult, $TaskHelperFilePath `
                @PSCommonParameters
        }
    }

    End {
        if ($tracerObject) {
            $global:DebugPreference = $oldDebugPreference
            Unregister-PSSwaggerClientTracing -TracerObject $tracerObject
        }
    }
}

