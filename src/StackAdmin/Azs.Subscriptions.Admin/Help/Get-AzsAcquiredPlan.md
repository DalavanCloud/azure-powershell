---
external help file: Azs.Subscriptions.Admin-help.xml
Module Name: Azs.Subscriptions.Admin
online version: 
schema: 2.0.0
---

# Get-AzsAcquiredPlan

## SYNOPSIS
Get a collection of all acquired plans that subscription has access to.

## SYNTAX

### AcquiredPlans_List (Default)
```
Get-AzsAcquiredPlan -TargetSubscriptionId <Guid> [-Top <Int32>] [-Skip <Int32>]
```

### AcquiredPlans_Get
```
Get-AzsAcquiredPlan -AcquisitionId <Guid> -TargetSubscriptionId <Guid>
```

### ResourceId_AcquiredPlans_Get
```
Get-AzsAcquiredPlan -ResourceId <String>
```

## DESCRIPTION
Get a collection of all acquired plans that subscription has access to.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsAcquiredPlan -TargetSubscriptionId "c90173b1-de7a-4b1d-8600-b832b0e65946"
```

## PARAMETERS

### -AcquisitionId
The plan acquisition Identifier

```yaml
Type: Guid
Parameter Sets: AcquiredPlans_Get
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
Parameter Sets: ResourceId_AcquiredPlans_Get
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
Parameter Sets: AcquiredPlans_List
Aliases: 

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetSubscriptionId
The target subscription ID.

```yaml
Type: Guid
Parameter Sets: AcquiredPlans_List, AcquiredPlans_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Top
Return the top N items as specified by the parameter value.
Applies after the -Skip parameter.

```yaml
Type: Int32
Parameter Sets: AcquiredPlans_List
Aliases: 

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Subscriptions.Admin.Models.PlanAcquisition

## NOTES

## RELATED LINKS
