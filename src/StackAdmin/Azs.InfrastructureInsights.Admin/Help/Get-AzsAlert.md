---
external help file: Azs.InfrastructureInsights.Admin-help.xml
Module Name: Azs.InfrastructureInsights.Admin
online version: 
schema: 2.0.0
---

# Get-AzsAlert

## SYNOPSIS
Returns the list of all alerts in a given region.

## SYNTAX

### List (Default)
```
Get-AzsAlert [-Location <String>] [-ResourceGroupName <String>] [-Filter <String>] [-Top <Int32>]
 [-Skip <Int32>] [<CommonParameters>]
```

### Get
```
Get-AzsAlert [-AlertId] <String> [-Location <String>] [-ResourceGroupName <String>] [<CommonParameters>]
```

### ResourceId
```
Get-AzsAlert -ResourceId <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the list of all alerts in a given region.

## EXAMPLES

### Example 1
```
PS C:\> Get-AzsAlert -ResourceGroup System.local -Region local

FaultTypeId                       ClosedTimestamp     ClosedByUserAlias                           Name                                 ResourceRegistrationId
-----------                       ---------------     -----------------                           ----                                 ----------------------
ServiceFabricClusterUnhealthy     08/25/2017 04:52:27                                             148820f7-807a-4edd-857b-a23c3dcb6acf ca96c335-e545-4563-9d65-058db3a8ef15
ServiceFabricApplicationUnhealthy 08/25/2017 18:48:31                                             17d030ef-7be7-4e12-a653-6158a3bc7643
AzureStackNotActivated            08/25/2017 18:21:34 ciserviceadmin@msazurestack.onmicrosoft.com 356fd53c-b355-4522-ab5b-1a0f385381fa
ServiceFabricApplicationUnhealthy 08/25/2017 04:33:12                                             37fab95e-8981-4657-872a-d0a904308d26
ServiceFabricApplicationUnhealthy 08/25/2017 04:52:27                                             7ff5f418-75e1-41e3-85c3-229e369313a3
ServiceFabricClusterUnhealthy     08/25/2017 04:33:12                                             b8f81ea8-cf7d-4909-a9f4-0779909e15eb ca96c335-e545-4563-9d65-058db3a8ef15
AzureStackNotActivated            08/25/2017 18:16:49 ciserviceadmin@msazurestack.onmicrosoft.com c0328148-006b-482b-9c75-ad58c454225b
AzureStackNotActivated            08/25/2017 18:29:55 ciserviceadmin@msazurestack.onmicrosoft.com cf278262-78cd-43eb-8cd8-9c4cac5e75f7
AzureStackNotActivated
```

Get all alerts in a region.

### Example 2
```
PS C:\> Get-AzsAlert -ResourceGroupName System.local -Region local -Name 060a41e5-0992-45a1-a472-5046329c1908

Fault Tags  Close Close Name  Resou Sever Creat LastU Resou Type  Remed Impac Title Impac Alert Descr Id    State Locat Fault AlertId
TypeI       dTime dByUs       rceRe ity   edTim pdate rcePr       iatio tedRe       tedRe Prope iptio             ion   Id
d           stamp erAli       gistr       estam dTime ovide       n     sourc       sourc rties n
                  as          ation       p     stamp rRegi             eId         eDisp
                              Id                      strat                         layNa
                                                      ionId                         me
----- ----  ----- ----- ----  ----- ----- ----- ----- ----- ----  ----- ----- ----- ----- ----- ----- --    ----- ----- ----- -------
Se... {}    02...       06...       Wa... 02... 02... e5... Mi... {S... /s... In... Ke... {[... {S... /s... Cl... local Se... 060a41e5-0992-45a1-a472-5046329c1908
```

Get an alert by name in a region.

## PARAMETERS

### -AlertId
The alert identifier.```yaml
Type: String
Parameter Sets: Get
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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
Name of the location.```yaml
Type: String
Parameter Sets: List, Get
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
resourceGroupName.

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

### Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert

## NOTES

## RELATED LINKS
