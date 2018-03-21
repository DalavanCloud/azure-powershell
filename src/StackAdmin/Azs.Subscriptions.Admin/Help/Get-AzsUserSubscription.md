---
external help file: Azs.Subscriptions.Admin-help.xml
Module Name: Azs.Subscriptions.Admin
online version: 
schema: 2.0.0
---

# Get-AzsUserSubscription

## SYNOPSIS
Get the list of user subscriptions as administrator.

## SYNTAX

### Subscriptions_List (Default)
```
Get-AzsUserSubscription [-Filter <String>]
```

### Subscriptions_Get
```
Get-AzsUserSubscription -SubscriptionId <Guid>
```

## DESCRIPTION
Get the list of user subscriptions as administrator.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-AzsUserSubscription
```

DelegatedProviderSubscriptionId : 0a823c45-d9e7-4812-a138-74e22213693a
DisplayName                     : cnur5172tenantresellersubscription696
Id                              : /subscriptions/0a823c45-d9e7-4812-a138-74e22213693a/providers/Microsoft.Subscriptions.Admin/subscriptions/c90173b1-de7a-4b1d-8600-b832b0e65946
ExternalReferenceId             :
OfferId                         : /subscriptions/0a823c45-d9e7-4812-a138-74e22213693a/resourceGroups/cnur5172resellersubscrrg696/providers/Microsoft.Subscriptions.Admin/offers/cnur5172tenant
                                subsvcoffer696
Owner                           : tenantadmin1@msazurestack.onmicrosoft.com
RoutingResourceManagerType      : Default
State                           : Enabled
SubscriptionId                  : c90173b1-de7a-4b1d-8600-b832b0e65946
TenantId                        : d669642b-89ec-466e-af2c-2ceab9fef685

## PARAMETERS

### -Filter
OData filter parameter.

```yaml
Type: String
Parameter Sets: Subscriptions_List
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubscriptionId
{{Fill SubscriptionId Description}}

```yaml
Type: Guid
Parameter Sets: Subscriptions_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Subscription

## NOTES

## RELATED LINKS
