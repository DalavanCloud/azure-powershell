---
external help file: Azs.Fabric.Admin-help.xml
Module Name: Azs.Fabric.Admin
online version:
schema: 2.0.0
---

# New-AzsIpPool

## SYNOPSIS
Create an IP pool.
Once created an IP pool cannot be deleted.

## SYNTAX

```
New-AzsIpPool [-EndIpAddress <String>] [-AddressPrefix <String>] [-StartIpAddress <String>]
 [-Tags <System.Collections.Generic.Dictionary`2[System.String,System.String]>] -Location <String>
 -ResourceGroupName <String> [-Name <String>] [-AsJob] [<CommonParameters>]
```

## DESCRIPTION
Create an IP pool.
Once created an IP pool cannot be deleted.

## EXAMPLES

### Example 1
```
PS C:\> New-AzsIpPool -ResourceGroup System.local -Name IpPool4 -StartIpAddress 192.168.99.1 -EndIpAddress 192.168.99.254 -AddressPrefix 192.168.99.0/24
```

Create a new IP pool.

## PARAMETERS

### -AddressPrefix
The address prefix.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsJob
Runs as a job.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndIpAddress
The ending IP address.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Location
The region where the resource is located.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
IP pool name.

```yaml
Type: String
Parameter Sets: (All)
Aliases: IpPool

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
Resource group in which the resource provider has been registered.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartIpAddress
The starting IP address.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tags
List of key-value pairs.

```yaml
Type: System.Collections.Generic.Dictionary`2[System.String,System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Fabric.Admin.Models.ProvisioningState

## NOTES

## RELATED LINKS
