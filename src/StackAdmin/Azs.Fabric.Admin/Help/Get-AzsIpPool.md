---
external help file: Azs.Fabric.Admin-help.xml
Module Name: Azs.Fabric.Admin
online version: 
schema: 2.0.0
---

# Get-AzsIpPool

## SYNOPSIS
Get infrastructure ip pools.

## SYNTAX

### List (Default)
```
Get-AzsIpPool [-Location <String>] [-ResourceGroupName <String>] [-Filter <String>] [-Skip <Int32>]
 [-Top <Int32>] [<CommonParameters>]
```

### Get
```
Get-AzsIpPool [-Name] <String> [-Location <String>] [-ResourceGroupName <String>] [<CommonParameters>]
```

### ResourceId
```
Get-AzsIpPool -ResourceId <String> [<CommonParameters>]
```

## DESCRIPTION
Get infrastructure ip pools.

## EXAMPLES

### Example 1
```
PS C:\> Get-AzsIpPool -ResourceGroup "System.local" -Location "redmond"

NumberOfIpAddressesInTransition StartIpAddress  Type                                           AddressPrefix NumberOfIpAddresses
------------------------------- --------------  ----                                           ------------- -------------------
0                               192.168.105.1   Microsoft.Fabric.Admin/fabricLocations/ipPools               255
0                               192.168.200.112 Microsoft.Fabric.Admin/fabricLocations/ipPools               16
0                               192.168.200.65  Microsoft.Fabric.Admin/fabricLocations/ipPools               47
0                               192.168.200.1   Microsoft.Fabric.Admin/fabricLocations/ipPools               62
0                               192.168.102.1   Microsoft.Fabric.Admin/fabricLocations/ipPools               255
0                               192.168.200.224 Microsoft.Fabric.Admin/fabricLocations/ipPools               31
```

Get a list of all infrastructure ip pools.

### Example 2
```
PS C:\> Get-AzsIpPool -ResourceGroup "System.local" -Location "redmond" -IpPool "08786a0f-ad8c-43aa-a154-06083abfc1ac"

NumberOfIpAddressesInTransition StartIpAddress Type                                           AddressPrefix NumberOfIpAddresses
------------------------------- -------------- ----                                           ------------- -------------------
0                               192.168.105.1  Microsoft.Fabric.Admin/fabricLocations/ipPools               255
```

Get an infrastructure ip pool based on name.

## PARAMETERS

### -Filter
OData filter parameter.

```yaml
Type: String
Parameter Sets: List
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Location
Location of the resource.

```yaml
Type: String
Parameter Sets: List, Get
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
IP pool name.

```yaml
Type: String
Parameter Sets: Get
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
Resource group in which the resource provider has been registered.

```yaml
Type: String
Parameter Sets: List, Get
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
Parameter Sets: ResourceId
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
Parameter Sets: List
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
Parameter Sets: List
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

### Microsoft.AzureStack.Management.Fabric.Admin.Models.IpPool

## NOTES

## RELATED LINKS
