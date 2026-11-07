---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/Products/Manage/REST#/TimeSheets
schema: 2.0.0
---

# Update-CWMTimeSheet

## SYNOPSIS
This will update a timesheet.

## SYNTAX

### Submit (Default)
```
Update-CWMTimeSheet -id <Int32> [-Submit] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Reject
```
Update-CWMTimeSheet -id <Int32> [-Reject] [-approvalType <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Reverse
```
Update-CWMTimeSheet -id <Int32> [-Reverse] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Approve
```
Update-CWMTimeSheet -id <Int32> [-Approve] [-approvalType <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
Update-CWMTimeSheet -id 1 -Submit
```

### EXAMPLE 2
```
Update-CWMTimeSheet -id 2 -Approve -ApprovalType 'Tier1Update'
```

## PARAMETERS

### -Approve
Allows the 'ApprovalType' parameter to be used.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Approve
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Reject
Rejects a timesheet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Reject
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Reverse
Reverses a timesheet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Reverse
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Submit
Submits a timesheet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Submit
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
{{ Fill id Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: sheetId

Required: True
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
Default value: False
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
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -approvalType
The type of value you want to assign.

```yaml
Type: System.String
Parameter Sets: Reject, Approve
Aliases:
Accepted values: DataEntry, Tier1Update, Tier2Update, Billing, Service, Project, MonthlySummary, SalesActivity, Schedule

Required: False
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
