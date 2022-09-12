---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Update-CWMTimeSheet

## SYNOPSIS
This will update a timesheet.

## SYNTAX

### Reject
```
Update-CWMTimeSheet -id <Int32> [-Reject] [<CommonParameters>]
```

### Reverse
```
Update-CWMTimeSheet -id <Int32> [-Reverse] [<CommonParameters>]
```

### Submit
```
Update-CWMTimeSheet -id <Int32> [-Submit] [<CommonParameters>]
```

### Approve
```
Update-CWMTimeSheet -id <Int32> [-Approve] [-ApprovalType <String>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
Update-CWMTimeSheet -id 1 -Submit
```

### Example 2
```powershell
Update-CWMTimeSheet -id 2 -Approve -ApprovalType 'Tier1Update'
```

## PARAMETERS

### -ApprovalType
The type of value you want to assign.

```yaml
Type: String
Parameter Sets: Approve
Aliases:
Accepted values: DataEntry, Tier1Update, Tier2Update, Billing, Service, Project, MonthlySummary, SalesActivity, Schedule

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Approve
Allows the 'ApprovalType' parameter to be used.

```yaml
Type: SwitchParameter
Parameter Sets: Approve
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Reject
Rejects a timesheet.

```yaml
Type: SwitchParameter
Parameter Sets: Reject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Reverse
Reverses a timesheet.

```yaml
Type: SwitchParameter
Parameter Sets: Reverse
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Submit
Submits a timesheet.

```yaml
Type: SwitchParameter
Parameter Sets: Submit
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
{{ Fill id Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: sheetId

Required: True
Position: Named
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

[https://developer.connectwise.com/Products/Manage/REST#/TimeSheets](https://developer.connectwise.com/Products/Manage/REST#/TimeSheets)