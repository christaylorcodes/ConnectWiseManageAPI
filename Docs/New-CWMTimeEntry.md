---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMTimeEntry

## SYNOPSIS
This function will create a new time entry.

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
 [-hourlyRate <Double>] [-timeSheet <Hashtable>] [-customFields <Hashtable[]>] [-_info <Hashtable>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
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
 [-timeSheet <Hashtable>] [-customFields <Hashtable[]>] [-_info <Hashtable>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
New-CWMTimeEntry
```

Create a new \<SOMETHING\>.

## PARAMETERS

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
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
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -_info
{{ Fill _info Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -actualHours
{{ Fill actualHours Description }}

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -addToDetailDescriptionFlag
{{ Fill addToDetailDescriptionFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -addToInternalAnalysisFlag
{{ Fill addToInternalAnalysisFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -addToResolutionFlag
{{ Fill addToResolutionFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -agreement
{{ Fill agreement Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billableOption
{{ Fill billableOption Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Billable, DoNotBill, NoCharge, NoDefault

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -businessUnitId
{{ Fill businessUnitId Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -chargeToId
{{ Fill chargeToId Description }}

```yaml
Type: Int32
Parameter Sets: ChargeTo
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -chargeToType
{{ Fill chargeToType Description }}

```yaml
Type: String
Parameter Sets: ChargeTo
Aliases:
Accepted values: ServiceTicket, ProjectTicket, ChargeCode, Activity

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -company
{{ Fill company Description }}

```yaml
Type: Hashtable
Parameter Sets: Company
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customFields
{{ Fill customFields Description }}

```yaml
Type: Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -dateEntered
{{ Fill dateEntered Description }}

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

### -emailCc
{{ Fill emailCc Description }}

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

### -emailCcFlag
{{ Fill emailCcFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailContactFlag
{{ Fill emailContactFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailResourceFlag
{{ Fill emailResourceFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -enteredBy
{{ Fill enteredBy Description }}

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

### -hourlyRate
{{ Fill hourlyRate Description }}

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -hoursBilled
{{ Fill hoursBilled Description }}

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -hoursDeduct
{{ Fill hoursDeduct Description }}

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
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
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -internalNotes
{{ Fill internalNotes Description }}

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

### -invoice
{{ Fill invoice Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -locationId
{{ Fill locationId Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -member
{{ Fill member Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mobileGuid
{{ Fill mobileGuid Description }}

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -notes
{{ Fill notes Description }}

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

### -timeEnd
{{ Fill timeEnd Description }}

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

### -timeSheet
{{ Fill timeSheet Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeStart
{{ Fill timeStart Description }}

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

### -workRole
{{ Fill workRole Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -workType
{{ Fill workType Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

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
Author: Chris Taylor Date: 1/7/2019

## RELATED LINKS

[https://developer.connectwise.com/manage/rest?a=Time&e=TimeEntries&o=CREATE](https://developer.connectwise.com/manage/rest?a=Time&e=TimeEntries&o=CREATE)

