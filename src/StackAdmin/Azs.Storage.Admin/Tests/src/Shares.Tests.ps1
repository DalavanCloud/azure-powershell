# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.SYNOPSIS
    Run AzureStack Shares admin tests

.DESCRIPTION
    Run AzureStack Shares admin tests using either mock client or our client.
	The mock client allows for recording and playback.  This allows for offline tests.

.PARAMETER RunRaw
    Run using our client creation path.

.EXAMPLE
    C:\PS> .\src\Shares.Tests.ps1
    Describing Shares
	  [+] TestGetShare 2.08s
	  [+] TestGetAllShares 1.62s
	  [+] TestListShares 1.60s
	  [+] TestListAllShareMetricDefinitions 1.96s
	  [+] TestListAllShareMetrics 1.81s

.NOTES
    Author: Deepa Thomas
	Copyright: Microsoft
    Date:   February 27, 2018
#>
param(
	[bool]$RunRaw = $false
)

$global:RunRaw = $RunRaw

. $PSScriptRoot\CommonModules.ps1

$global:TestName = ""

InModuleScope Azs.Storage.Admin {

	Describe "Shares" -Tags @('Shares', 'Azs.Storage.Admin') {
	
		BeforeEach  {

			. $PSScriptRoot\Common.ps1

			function AssertAreEqual {
				param(
					[Parameter(Mandatory=$true)]
					$expected,
					[Parameter(Mandatory=$true)]
					$found
				)
				# Resource
				if($expected -eq $null){
					$found												    | Should Be $null
				}
				else{
				    $found												    | Should Not Be $null
					# Validate Share properties
					$expected.FreeCapacity	| Should Be $found.FreeCapacity
					$expected.HealthStatus	| Should Be $found.HealthStatus
					$expected.Id			| Should Be $found.Id
					$expected.Location		| Should Be $found.Location
					$expected.Name			| Should Be $found.Name
					$expected.ShareName		| Should Be $found.ShareName
					$expected.TotalCapacity | Should Be $found.TotalCapacity
					$expected.Type			| Should Be $found.Type
					$expected.UncPath		| Should Be $found.UncPath
					$expected.UsedCapacity	| Should Be $found.UsedCapacity
				}
			}

			function ValidateShare {
				param(
					[Parameter(Mandatory=$true)]
					$share
				)
				# Resource
				$share								| Should Not Be $null

				# Validate Share properties
				$share.FreeCapacity					| Should Not Be $null
				$share.HealthStatus					| Should Not Be $null
				$share.Id							| Should Not Be $null
				$share.Location						| Should Not Be $null
				$share.Name							| Should Not Be $null
				$share.ShareName					| Should Not Be $null
				$share.TotalCapacity				| Should Not Be $null
				$share.Type							| Should Not Be $null
				$share.UncPath						| Should Not Be $null
				$share.UsedCapacity					| Should Not Be $null
			}
		}

		It "TestGetShare" {
			$global:TestName = 'TestGetShare'
				
			$farms =  Get-AzsStorageFarm -ResourceGroupName $global:ResourceGroup
			foreach($farm in $farms) {
				$shares = Get-AzsStorageShare -ResourceGroupName $global:ResourceGroup -FarmId (Select-Name $farm.Name)
				foreach($share in $shares) {
					$result = Get-AzsStorageShare -ResourceGroupName $global:ResourceGroup -Name (Select-Name $share.Name) -FarmId (Select-Name $farm.Name)
					$result  | Should Not Be $null
					ValidateShare -share $result
					AssertAreEqual -expected $share -found $result 
				}
			}
		}

		It "TestGetAllShares" {
			$global:TestName = 'TestGetAllShares'
				
			$farms =  Get-AzsStorageFarm -ResourceGroupName $global:ResourceGroup
			foreach($farm in $farms) {
				$shares = Get-AzsStorageShare -ResourceGroupName $global:ResourceGroup -FarmId (Select-Name $farm.Name)
				foreach($share in $shares) {
					$result = Get-AzsStorageShare -ResourceGroupName $global:ResourceGroup -Name (Select-Name $share.Name) -FarmId (Select-Name $farm.Name)
					$result  | Should Not Be $null
					ValidateShare -share $result
					AssertAreEqual -expected $share -found $result 
				}
			}
		}

		It "TestListShares" {
			$global:TestName = 'TestListShares'
				
			$farms =  Get-AzsStorageFarm -ResourceGroupName $global:ResourceGroup
			foreach($farm in $farms) {
				$shares = Get-AzsStorageShare -ResourceGroupName $global:ResourceGroup -FarmId (Select-Name $farm.Name)
				foreach($share in $shares) {
					ValidateShare -share $share
				}
			}
		}

		It "TestListAllShareMetricDefinitions" {
			$global:TestName = 'TestListAllShareMetricDefinitions'
				
			$farms =  Get-AzsStorageFarm -ResourceGroupName $global:ResourceGroup
			foreach($farm in $farms) {
				$shares = Get-AzsStorageShare -ResourceGroupName $global:ResourceGroup -FarmId (Select-Name $farm.Name)
				foreach($share in $shares) {
					$metricDefinitions = Get-AzsStorageShareMetricDefinition -ResourceGroupName $global:ResourceGroup -ShareName (Select-Name $share.Name) -FarmId (Select-Name $farm.Name)
					$metricDefinitions  | Should Not Be $null
				}
			}
		}

		It "TestListAllShareMetrics" {
			$global:TestName = 'TestListAllShareMetrics'
				
			$farms =  Get-AzsStorageFarm -ResourceGroupName $global:ResourceGroup
			foreach($farm in $farms) {
				$shares = Get-AzsStorageShare -ResourceGroupName $global:ResourceGroup -FarmId (Select-Name $farm.Name)
				foreach($share in $shares) {
					$metrics = Get-AzsStorageShareMetric -ResourceGroupName $global:ResourceGroup -ShareName (Select-Name $share.Name) -FarmId (Select-Name $farm.Name)
					$metrics  | Should Not Be $null
				}
			}
		}
	}
}