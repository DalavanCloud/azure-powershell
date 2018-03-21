---
external help file: Azs.Subscriptions.Admin-help.xml
Module Name: Azs.Subscriptions.Admin
online version: 
schema: 2.0.0
---

# New-AzsOfferDelegation

## SYNOPSIS
Get the list of offers.

## SYNTAX

```
New-AzsOfferDelegation -Name <String> -OfferName <String> -SubscriptionId <String> -ResourceGroupName <String>
 [-Location <String>]
```

## DESCRIPTION
Get the list of offers.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
New-AzsOfferDelegation -Offer offer1 -ResourceGroupName rg1 -Name delegate1 -SubscriptionId "c90173b1-de7a-4b1d-8600-b832b0e65946" -Location "local"
```

SubscriptionId : c90173b1-de7a-4b1d-8600-b832b0e65946
Id             : /subscriptions/0a823c45-d9e7-4812-a138-74e22213693a/resourceGroups/rg1/providers/Microsoft.Subscriptions.Admin/offers/offer1/offerDelegations/delegate1
Name           : offer1/delegate1
Type           : Microsoft.Subscriptions.Admin/offers/offerDelegations
Location       : local
Tags           :

## PARAMETERS

### -Location
Location of the resource.

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

### -Name
Name of a offer delegation.

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

### -OfferName
Name of an offer.

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

### -ResourceGroupName
{{Fill ResourceGroupName Description}}

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

### -SubscriptionId
Identifier of the subscription receiving the delegated offer.

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

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Subscriptions.Admin.Models.OfferDelegation

## NOTES

## RELATED LINKS
