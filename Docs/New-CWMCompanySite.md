---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://christaylor.codes
schema: 2.0.0
---

# New-CWMCompanySite

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

```
New-CWMCompanySite [-parentId] <Int32> [[-id] <Int32>] [-name] <String> [[-addressLine1] <String>]
 [[-addressLine2] <String>] [[-city] <String>] [[-stateReference] <Hashtable>] [[-zip] <String>]
 [[-country] <Hashtable>] [[-phoneNumber] <String>] [[-phoneNumberExt] <String>] [[-faxNumber] <String>]
 [[-taxCode] <Hashtable>] [[-entityType] <Hashtable>] [[-expenseReimbursement] <Double>]
 [[-primaryAddressFlag] <Boolean>] [[-defaultShippingFlag] <Boolean>] [[-defaultBillingFlag] <Boolean>]
 [[-defaultMailingFlag] <Boolean>] [[-inactiveFlag] <Boolean>] [[-billSeperateFlag] <Boolean>]
 [[-mobileGuid] <String>] [[-calendar] <Hashtable>] [[-timeZone] <Hashtable>] [[-customFields] <Hashtable>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -addressLine1
{{ Fill addressLine1 Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -addressLine2
{{ Fill addressLine2 Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billSeperateFlag
{{ Fill billSeperateFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -calendar
{{ Fill calendar Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -city
{{ Fill city Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -country
{{ Fill country Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customFields
{{ Fill customFields Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -defaultBillingFlag
{{ Fill defaultBillingFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -defaultMailingFlag
{{ Fill defaultMailingFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -defaultShippingFlag
{{ Fill defaultShippingFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -entityType
{{ Fill entityType Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -expenseReimbursement
{{ Fill expenseReimbursement Description }}

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -faxNumber
{{ Fill faxNumber Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
{{ Fill id Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -inactiveFlag
{{ Fill inactiveFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mobileGuid
{{ Fill mobileGuid Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -name
{{ Fill name Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -parentId
{{ Fill parentId Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: companyId

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -phoneNumber
{{ Fill phoneNumber Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -phoneNumberExt
{{ Fill phoneNumberExt Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -primaryAddressFlag
{{ Fill primaryAddressFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -stateReference
{{ Fill stateReference Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -taxCode
{{ Fill taxCode Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeZone
{{ Fill timeZone Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -zip
{{ Fill zip Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
