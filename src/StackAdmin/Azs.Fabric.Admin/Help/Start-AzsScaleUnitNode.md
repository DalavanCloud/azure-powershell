---
external help file: Azs.Fabric.Admin-help.xml
Module Name: Azs.Fabric.Admin
online version:
schema: 2.0.0
---

# Start-AzsScaleUnitNode

## SYNOPSIS
Power on a scale unit node.

## SYNTAX

### PowerOn (Default)
```
Start-AzsScaleUnitNode -Name <String> [-Location <String>] [-ResourceGroupName <String>] [-Wait]
 [<CommonParameters>]
```

### ResourceId
```
Start-AzsScaleUnitNode -ResourceId <String> [-Wait] [<CommonParameters>]
```

## DESCRIPTION
Power on a scale unit node.

## EXAMPLES

### EXAMPLE 1
```
Start-AzsScaleUnitNode -ResourceGroup "System.local" -Location "local" -InfrastructureRoleInstance "AzS-ACS01"
ProvisioningState : Succeeded
```

Power on a scale unit node.

## PARAMETERS

### -Location
Location of the resource.

```yaml
Type: String
Parameter Sets: PowerOn
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the scale unit node.

```yaml
Type: String
Parameter Sets: PowerOn
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
Resource group in which the resource provider has been registered.

```yaml
Type: String
Parameter Sets: PowerOn
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceId
Scale unit node resource ID.

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

### -Wait
{{Fill Wait Description}}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS