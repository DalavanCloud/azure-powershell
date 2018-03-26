---
external help file: Azs.Subscriptions.Admin-help.xml
Module Name: Azs.Subscriptions.Admin
online version:
schema: 2.0.0
---

# Get-AzsDirectoryTenant

## SYNOPSIS
Lists all the directory tenants under the current subscription and given resource group name.

## SYNTAX

### DirectoryTenants_List (Default)
```
Get-AzsDirectoryTenant [-ResourceGroupName <String>] [-Top <Int32>] [-Skip <Int32>] [<CommonParameters>]
```

### DirectoryTenants_Get
```
Get-AzsDirectoryTenant -Name <String> [-ResourceGroupName <String>] [<CommonParameters>]
```

### ResourceId_DirectoryTenants_Get
```
Get-AzsDirectoryTenant -ResourceId <String> [<CommonParameters>]
```

## DESCRIPTION
Lists all the directory tenants under the current subscription and given resource group name.

## EXAMPLES

### EXAMPLE 1
```
Get-AzsDirectoryTenant -ResourceGroupName "System.Local"
```

TenantId : d669642b-89ec-466e-af2c-2ceab9fef685
Id       : /subscriptions/0a823c45-d9e7-4812-a138-74e22213693a/resourceGroups/System.Local/providers/Microsoft.Subscriptions.Admin/directoryTenants/azurestackci04.onmicrosoft.com
Name     : azurestackci04.onmicrosoft.com
Type     : Microsoft.Subscriptions.Admin/directoryTenants
Location : local

## PARAMETERS

### -Name
Directory tenant name.

```yaml
Type: String
Parameter Sets: DirectoryTenants_Get
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
{{Fill ResourceGroupName Description}}

```yaml
Type: String
Parameter Sets: DirectoryTenants_List, DirectoryTenants_Get
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceId
The resource id.

```yaml
Type: String
Parameter Sets: ResourceId_DirectoryTenants_Get
Aliases: id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Skip
Skip the first N items as specified by the parameter value.

```yaml
Type: Int32
Parameter Sets: DirectoryTenants_List
Aliases:

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

### -Top
Return the top N items as specified by the parameter value.
Applies after the -Skip parameter.

```yaml
Type: Int32
Parameter Sets: DirectoryTenants_List
Aliases:

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Subscriptions.Admin.Models.DirectoryTenant

## NOTES

## RELATED LINKS