---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# New-CWMTimeEntry

## SYNOPSIS
Creates a time entry.

## SYNTAX

### Company
```
New-CWMTimeEntry [-id <Int32>] -company <Hashtable> [-member <Hashtable>] [-locationId <Int32>]
 [-businessUnitId <Int32>] [-workType <Hashtable>] [-workRole <Hashtable>] [-agreement <Hashtable>]
 -timeStart <String> [-timeEnd <String>] [-hoursDeduct <Double>] [-actualHours <Double>]
 [-billableOption <String>] [-notes <String>] [-internalNotes <String>] [-addToDetailDescriptionFlag <Boolean>]
 [-addToInternalAnalysisFlag <Boolean>] [-addToResolutionFlag <Boolean>] [-emailResourceFlag <Boolean>]
 [-emailContactFlag <Boolean>] [-emailCcFlag <Boolean>] [-emailCc <String>] [-hoursBilled <Double>]
 [-enteredBy <String>] [-dateEntered <String>] [-invoice <Hashtable>] [-mobileGuid <Guid>]
 [-hourlyRate <Double>] [-timeSheet <Hashtable>] [-customFields <Hashtable[]>] [-_info <Hashtable>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ChargeTo
```
New-CWMTimeEntry [-id <Int32>] -chargeToId <Int32> -chargeToType <String> [-member <Hashtable>]
 [-locationId <Int32>] [-businessUnitId <Int32>] [-workType <Hashtable>] [-workRole <Hashtable>]
 [-agreement <Hashtable>] -timeStart <String> [-timeEnd <String>] [-hoursDeduct <Double>]
 [-actualHours <Double>] [-billableOption <String>] [-notes <String>] [-internalNotes <String>]
 [-addToDetailDescriptionFlag <Boolean>] [-addToInternalAnalysisFlag <Boolean>]
 [-addToResolutionFlag <Boolean>] [-emailResourceFlag <Boolean>] [-emailContactFlag <Boolean>]
 [-emailCcFlag <Boolean>] [-emailCc <String>] [-hoursBilled <Double>] [-enteredBy <String>]
 [-dateEntered <String>] [-invoice <Hashtable>] [-mobileGuid <Guid>] [-hourlyRate <Double>]
 [-timeSheet <Hashtable>] [-customFields <Hashtable[]>] [-_info <Hashtable>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a time entry in ConnectWise Manage.
Calls POST /time/entries; only the parameters you pass are
sent in the request body.

## EXAMPLES

### EXAMPLE 1
```
New-CWMTimeEntry -chargeToType 'ServiceTicket' -chargeToId 1234 -member @{ id = 10 } -timeStart (ConvertTo-CWMTime (Get-Date).AddHours(-1) -Raw) -timeEnd (ConvertTo-CWMTime (Get-Date) -Raw) -notes 'Replaced the failed drive.'
```

Logs the last hour of work by member 10 against service ticket 1234.

## PARAMETERS

### -id
The id property of the request body.
Usually left unset; ConnectWise Manage assigns the id of a new
record.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -company
Company reference, for example @{ id = 250 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: Company
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -chargeToId
Charge to id.
An integer.
If chargeToId is not specified, we assume you enter time against the company
specified.

```yaml
Type: System.Int32
Parameter Sets: ChargeTo
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -chargeToType
Charge to type.
One of: Company, ServiceTicket, ProjectTicket, ChargeCode, Activity.
If chargeToId is
not specified, we assume you enter time against the company specified.

```yaml
Type: System.String
Parameter Sets: ChargeTo
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -member
Member reference, for example @{ id = 10 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -locationId
Location id.
An integer.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -businessUnitId
Business unit id.
An integer.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -workType
Work type reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -workRole
Work role reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -agreement
Agreement reference, for example @{ id = 30 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeStart
Time start.
Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.
Required by
the API.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeEnd
Time end.
Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -hoursDeduct
Hours deduct.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -actualHours
Actual hours.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -billableOption
Billable option.
One of: Billable, DoNotBill, NoCharge, NoDefault.
Required on updates.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -notes
Notes.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -internalNotes
Internal notes.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -addToDetailDescriptionFlag
Add to detail description flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -addToInternalAnalysisFlag
Add to internal analysis flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -addToResolutionFlag
Add to resolution flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailResourceFlag
Email resource flag.
$true or $false.
This is an action flag.
To update this value use the
/service/tickets endpoint automaticEmailResourceFlag field.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailContactFlag
Email contact flag.
$true or $false.
This is an action flag.
To update this value use the
/service/tickets endpoint automaticEmailContactFlag field.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailCcFlag
Email CC flag.
$true or $false.
This is an action flag.
To update this value use the /service/tickets
endpoint automaticEmailCcFlag field.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailCc
Email CC.
To update this value use the /service/tickets endpoint automaticEmailCc field.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -hoursBilled
Hours billed.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -enteredBy
Entered by.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -dateEntered
Date entered.
Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoice
Invoice reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mobileGuid
Mobile GUID.

```yaml
Type: System.Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -hourlyRate
Hourly rate.
A number.
This field may only be Updated, it is defaulted on Create.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeSheet
Time sheet reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customFields
Custom fields.
An array of custom field values, for example @(@{ id = 4; value = 'Gold' }).

```yaml
Type: System.Collections.Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -_info
The _info metadata of the record, as returned by the API.
Usually left unset.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

