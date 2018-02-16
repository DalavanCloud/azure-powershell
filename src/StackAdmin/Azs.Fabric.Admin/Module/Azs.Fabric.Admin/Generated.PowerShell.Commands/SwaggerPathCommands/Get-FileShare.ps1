<#
The MIT License (MIT)

Copyright (c) 2017 Microsoft

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
#>

Import-Module -Name (Join-Path -Path $PSScriptRoot -ChildPath .. | Join-Path -ChildPath .. | Join-Path -ChildPath "GeneratedHelpers.psm1")
<#
.DESCRIPTION
    Get files shares.

.PARAMETER Filter
    OData filter parameter.

.PARAMETER FileShare
    Fabric file share name.

.PARAMETER Location
    Location of the resource.

.EXAMPLE

Get-AzsFileShare -Location "local"

Type                                              UncPath                                               Name                 Location AssociatedVolume
----                                              -------                                               ----                 -------- ----------------
Microsoft.Fabric.Admin/fabricLocations/fileShares \\SU1FileServer.azurestack.local\SU1_Infrastructure_1 SU1_Infrastructure_1 local    a42d219b
Microsoft.Fabric.Admin/fabricLocations/fileShares \\SU1FileServer.azurestack.local\SU1_Infrastructure_2 SU1_Infrastructure_2 local    a42d219b
Microsoft.Fabric.Admin/fabricLocations/fileShares \\SU1FileServer.azurestack.local\SU1_Infrastructure_3 SU1_Infrastructure_3 local    a42d219b
Microsoft.Fabric.Admin/fabricLocations/fileShares \\SU1FileServer.azurestack.local\SU1_ObjStore         SU1_ObjStore         local    a42d219b
Microsoft.Fabric.Admin/fabricLocations/fileShares \\SU1FileServer.azurestack.local\SU1_Public           SU1_Public           local    a42d219b
Microsoft.Fabric.Admin/fabricLocations/fileShares \\SU1FileServer.azurestack.local\SU1_VmTemp           SU1_VmTemp           local    a42d219b

.EXAMPLE

Get-AzsFileShare -Location -FileShare "SU1_Infrastructure_1"

Type                                              UncPath                                               Name                 Location AssociatedVolume
----                                              -------                                               ----                 -------- ----------------
Microsoft.Fabric.Admin/fabricLocations/fileShares \\SU1FileServer.azurestack.local\SU1_Infrastructure_1 SU1_Infrastructure_1 local    a42d219b

#>
function Get-FileShare
{
    [OutputType([Microsoft.AzureStack.Management.Fabric.Admin.Models.FileShare])]
    [CmdletBinding(DefaultParameterSetName='FileShares_List')]
    param(    
        [Parameter(Mandatory = $false, ParameterSetName = 'FileShares_List')]
        [string]
        $Filter,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'FileShares_Get')]
        [System.String]
        $FileShare,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'FileShares_List')]
        [Parameter(Mandatory = $true, ParameterSetName = 'FileShares_Get')]
        [System.String]
        $Location
    )

    Begin 
    {
	}

    Process {
    
    $ErrorActionPreference = 'Stop'
    
    $FabricAdminClient = Get-ServiceClient
    
    $oDataQuery = ""
    if ($Filter) { $oDataQuery += "&`$Filter=$Filter" }
    $oDataQuery = $oDataQuery.Trim("&")
    
    

    $skippedCount = 0
    $returnedCount = 0
    if ('FileShares_Get' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $FabricAdminClient.'
        $taskResult = $FabricAdminClient.FileShares.GetWithHttpMessagesAsync($Location, $FileShare)
    } elseif ('FileShares_List' -eq $PsCmdlet.ParameterSetName ) {
        Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $FabricAdminClient.'
        $taskResult = $FabricAdminClient.FileShares.ListWithHttpMessagesAsync($Location, $(if ($oDataQuery) { New-Object -TypeName "Microsoft.Rest.Azure.OData.ODataQuery``1[Microsoft.AzureStack.Management.Fabric.Admin.Models.FileShare]" -ArgumentList $oDataQuery } else { $null }))
    } else {
        Write-Verbose -Message 'Failed to map parameter set to operation method.'
        throw 'Module failed to find operation to execute.'
    }

    if ($TaskResult) {
        $result = $null
        $ErrorActionPreference = 'Stop'
                    
        $null = $taskResult.AsyncWaitHandle.WaitOne()
                    
        Write-Debug -Message "$($taskResult | Out-String)"

        if($taskResult.IsFaulted)
        {
            Write-Verbose -Message 'Operation failed.'
            Throw "$($taskResult.Exception.InnerExceptions | Out-String)"
        } 
        elseif ($taskResult.IsCanceled)
        {
            Write-Verbose -Message 'Operation got cancelled.'
            Throw 'Operation got cancelled.'
        }
        else
        {
            Write-Verbose -Message 'Operation completed successfully.'

            if($taskResult.Result -and
                (Get-Member -InputObject $taskResult.Result -Name 'Body') -and
                $taskResult.Result.Body)
            {
                $result = $taskResult.Result.Body
                Write-Debug -Message "$($result | Out-String)"
                $result
            }
        }
        
    }
    }

    End {
    }
}