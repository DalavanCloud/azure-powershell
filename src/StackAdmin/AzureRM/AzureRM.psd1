﻿#
# Module manifest for module 'AzureRM.Installer'
#
# Generated by: Microsoft Corporation
#
# Generated on: 9/18/2015
#

@{

# Script module or binary module file associated with this manifest.


# Version number of this module.
ModuleVersion = '1.2.12'

# ID used to uniquely identify this module
GUID = 'B433E830-B479-4F7F-9C80-9CC6C28E1B51'

# Author of this module
Author = 'Microsoft Corporation'

# Company or vendor of this module
CompanyName = 'Microsoft Corporation'

# Copyright statement for this module
Copyright = 'Microsoft Corporation. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Azure Resource Manager Module'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '3.0'

# Name of the Windows PowerShell host required by this module
PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
PowerShellHostVersion = ''

# Minimum version of the .NET Framework required by this module
DotNetFrameworkVersion = '4.0'

# Minimum version of the common language runtime (CLR) required by this module
CLRVersion='4.0'

# Processor architecture (None, X86, Amd64, IA64) required by this module
ProcessorArchitecture = 'None'

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @(@{ModuleName="AzureRM.Profile"; RequiredVersion="4.4.0"},
  @{ModuleName="Azure.Storage"; RequiredVersion="1.0.5.4"}
  @{ModuleName="AzureRM.Compute"; RequiredVersion="1.2.3.4"},
  @{ModuleName="AzureRM.Dns"; RequiredVersion="4.1.0"},
  @{ModuleName="AzureRM.KeyVault"; RequiredVersion="4.2.0"},
  @{ModuleName="AzureRM.Network"; RequiredVersion="1.0.5.4"},
  @{ModuleName="AzureRM.Resources"; RequiredVersion="5.5.0"},
  @{ModuleName="AzureRM.Storage"; RequiredVersion="1.0.5.4"},
  @{ModuleName="AzureRM.Tags"; RequiredVersion="4.0.0"},
  @{ModuleName="AzureRM.UsageAggregates"; RequiredVersion="4.0.1"})

# Assemblies that must be loaded prior to importing this module
RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module
ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
TypesToProcess = @(
)

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = @(
)

# Modules to import as nested modules of the module specified in ModuleToProcess
NestedModules = @(
)

# Functions to export from this module
FunctionsToExport = '*'

# Cmdlets to export from this module
CmdletsToExport = '*'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module
AliasesToExport = @()

# List of all modules packaged with this module
ModuleList = @()

# List of all files packaged with this module
FileList =  @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        # Tags = @()

        # A URL to the license for this module.
        LicenseUri = 'https://aka.ms/azps-license'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/Azure/azure-powershell'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = '## 2017.10.12 - Version 1.2.11
        * The release 1.2.11 comes with a list of breaking changes. To upgrade from the 1.2.10 version, we have created a migration guide at https://aka.ms/azSpowershellmigration
        * Profile
            * Context persistence has been enabled, refer to the link for the details https://docs.microsoft.com/en-us/powershell/azure/context-persistence
            * Add-AzureRmAccount - EnvironmentName parameter has been removed and replaced with Environment
            * Select-AzureRmContext has been renamed to Import-AzureRmContext
            * Save-AzureRmProfile has been renamed to Save-AzureRmContext
            * -Force Parameter has been deprecated from Remove-AzureRmEnvironment
            * Refer to the migration guide https://aka.ms/azSpowershellmigration for the object model changes
        * Compute
            * Tags parameter has been changed to Tag and the type was changed from HashTable[] to HashTable for the cmdlets New-AzureRmVM and Update-AzureRmVM
        * Dns
            * Tags parameter has been changed to Tag and the type was changed from HashTable[] to HashTable for the cmdlets New-AzureRmDnsZone and Set-AzureRmDnsZone
        * KeyVault
            * Tags parameter has been changed to Tag and the type was changed from HashTable[] to HashTable for the cmdlets New-AzureRmDnsZone and Set-AzureRmDnsZone
        * Network
            * Tags parameter has been changed to Tag and the type was changed from HashTable[] to HashTable for the following cmdlets
                  - New-AzureRmApplicationGateway
                  - New-AzureRmExpressRouteCircuit
                  - New-AzureRmLoadBalancer
                  - New-AzureRmLocalNetworkGateway
                  - New-AzureRmNetworkInterface
                  - New-AzureRmNetworkSecurityGroup
                  - New-AzureRmPublicIpAddress
                  - New-AzureRmRouteTable
                  - New-AzureRmVirtualNetwork
                  - New-AzureRmVirtualNetworkGateway
                  - New-AzureRmVirtualNetworkGatewayConnection
                  - New-AzureRmVirtualNetworkPeering
        * Resources
            * -Force parmeter has been removed from the following cmdlets
                  - Register-AzureRmProviderFeature
                  - Register-AzureRmResourceProvider
                  - Remove-AzureRmADServicePrincipal
                  - Remove-AzureRmPolicyAssignment
                  - Remove-AzureRmResourceGroupDeployment
                  - Remove-AzureRmRoleAssignment
                  - Stop-AzureRmResourceGroupDeployment
                  - Unregister-AzureRmResourceProvider
        * Tag
            * -Force parmeter has been removed from the cmdlet Remove-AzureRmTag'

        # External dependent modules of this module
        # ExternalModuleDependencies = ''

    } # End of PSData hashtable

 } # End of PrivateData hashtable

}
