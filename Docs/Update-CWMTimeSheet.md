---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Update-CWMTimeSheet

## SYNOPSIS
Submits, approves, rejects or reverses a time sheet.

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
Runs a time sheet action.
Calls POST /time/sheets/{id}/submit (the default), /approve, /reject or
/reverse.
Approve and reject send a TimeSheetTierUpdate body with the id and, if given, the approval
type.

## EXAMPLES

### EXAMPLE 1
```
Update-CWMTimeSheet -id 88 -Approve -approvalType Tier1Update
```

Approves time sheet 88 at tier 1.

### EXAMPLE 2
```
Update-CWMTimeSheet -id 88 -Reverse
```

Reverses time sheet 88.

## PARAMETERS

### -id
The id of the time sheet.
Alias: sheetId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: sheetId

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Reject
Reject the time sheet (POST /time/sheets/{id}/reject).

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
Reverse the time sheet (POST /time/sheets/{id}/reverse).

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
Submit the time sheet (POST /time/sheets/{id}/submit).
This is the default action.

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

### -Approve
Approve the time sheet (POST /time/sheets/{id}/approve).

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

### -approvalType
With -Approve or -Reject, the approval tier sent as approvalType in the request body.
One of: DataEntry,
Tier1Update, Tier2Update, Billing, Service, Project, MonthlySummary, SalesActivity, Schedule.

```yaml
Type: System.String
Parameter Sets: Reject, Approve
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

[Submit-CWMTimeSheet]()

[Get-CWMTimeSheet]()

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

