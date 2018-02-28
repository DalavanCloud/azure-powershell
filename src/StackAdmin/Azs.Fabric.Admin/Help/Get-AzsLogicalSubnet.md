---
external help file: Azs.Fabric.Admin-help.xml
Module Name: Azs.Fabric.Admin
online version:
schema: 2.0.0
---

# Get-AzsLogicalSubnet

## SYNOPSIS
Get logical subnets under a logical network at a specific location.

## SYNTAX

### LogicalSubnets_List (Default)
```
Get-AzsLogicalSubnet [-Filter <String>] [-Skip <Int32>] -ResourceGroupName <String> -LogicalNetwork <String>
 -Location <String> [-Top <Int32>] [<CommonParameters>]
```

### ResourceId_LogicalSubnets_Get
```
Get-AzsLogicalSubnet -ResourceId <String> [<CommonParameters>]
```

### LogicalSubnets_Get
```
Get-AzsLogicalSubnet -ResourceGroupName <String> -LogicalNetwork <String> -Location <String> -Name <String>
 [<CommonParameters>]
```

### InputObject_LogicalSubnets_Get
```
Get-AzsLogicalSubnet -InputObject <LogicalSubnet> [<CommonParameters>]
```

## DESCRIPTION
Get logical subnets under a logical network at a specific location.

## EXAMPLES

### Example 1
```
PS C:\> Get-AzsLogicalSubnet -ResourceGroup "System.local" -Location "local" -LogicalNetwork "00000000-2222-1111-9999-000000000001"

Type                                                                  Metadata Name                                 Location IsPublic
----                                                                  -------- ----                                 -------- --------
Microsoft.Fabric.Admin/fabricLocations/logicalNetworks/logicalSubnets          d8cfef2d-c0c8-4cdb-b0a8-fb1bdf3f2ad7 local    False
```

Get a list of all logical subnets for a given logical network and location.

### Example 2
```
PS C:\> Get-AzsLogicalSubnet -ResourceGroup "System.local" -Location "local" -LogicalNetwork "00000000-2222-1111-9999-000000000001" -LogicalSubnet "d8cfef2d-c0c8-4cdb-b0a8-fb1bdf3f2ad7"

Type                                                                  Metadata Name                                 Location IsPublic
----                                                                  -------- ----                                 -------- --------
Microsoft.Fabric.Admin/fabricLocations/logicalNetworks/logicalSubnets          d8cfef2d-c0c8-4cdb-b0a8-fb1bdf3f2ad7 local    False
```

Get a specific logical subnet for a given logical network and location based on name.

## PARAMETERS

### -Filter
OData filter parameter.

```yaml
Type: String
Parameter Sets: LogicalSubnets_List
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
The input object of type Microsoft.AzureStack.Management.Fabric.Admin.Models.LogicalSubnet.

```yaml
Type: LogicalSubnet
Parameter Sets: InputObject_LogicalSubnets_Get
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Location
Location of the resource.

```yaml
Type: String
Parameter Sets: LogicalSubnets_List, LogicalSubnets_Get
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogicalNetwork
Name of the logical network.

```yaml
Type: String
Parameter Sets: LogicalSubnets_List, LogicalSubnets_Get
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the logical subnet.

```yaml
Type: String
Parameter Sets: LogicalSubnets_Get
Aliases: LogicalSubnet

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
Name of the resource group.

```yaml
Type: String
Parameter Sets: LogicalSubnets_List, LogicalSubnets_Get
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceId
The resource id.

```yaml
Type: String
Parameter Sets: ResourceId_LogicalSubnets_Get
Aliases:

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
Parameter Sets: LogicalSubnets_List
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
Parameter Sets: LogicalSubnets_List
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

### Microsoft.AzureStack.Management.Fabric.Admin.Models.LogicalSubnet

## NOTES

## RELATED LINKS
