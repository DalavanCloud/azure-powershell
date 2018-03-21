---
external help file: Azs.Subscriptions.Admin-help.xml
Module Name: Azs.Subscriptions.Admin
online version: 
schema: 2.0.0
---

# Get-AzsDelegatedProviderManagedOffer

## SYNOPSIS
Get the list of delegated provider offers.

## SYNTAX

### DelegatedProviderOffers_List (Default)
```
Get-AzsDelegatedProviderManagedOffer -DelegatedProvider <String> [-Skip <Int32>] [-Top <Int32>]
```

### DelegatedProviderOffers_Get
```
Get-AzsDelegatedProviderManagedOffer -DelegatedProvider <String> -Name <String>
```

### ResourceId_DelegatedProviderOffers_Get
```
Get-AzsDelegatedProviderManagedOffer -ResourceId <String>
```

## DESCRIPTION
Get the list of delegated provider offers.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsDelegatedProviderManagedOffer -DelegatedProvider "c90173b1-de7a-4b1d-8600-b832b0e65946"
```

## PARAMETERS

### -DelegatedProvider
DelegatedProvider identifier.

```yaml
Type: String
Parameter Sets: DelegatedProviderOffers_List, DelegatedProviderOffers_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of an offer.

```yaml
Type: String
Parameter Sets: DelegatedProviderOffers_Get
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
Parameter Sets: ResourceId_DelegatedProviderOffers_Get
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
Parameter Sets: DelegatedProviderOffers_List
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
Parameter Sets: DelegatedProviderOffers_List
Aliases: 

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Subscriptions.Admin.Models.DelegatedProviderOffer

## NOTES

## RELATED LINKS
