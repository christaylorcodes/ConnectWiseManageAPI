---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/Products/Manage/REST?a=Time&e=Timesheets&o=DELETE
schema: 2.0.0
---

# Remove-CWMTimesheet

## SYNOPSIS
Remove a timesheet from the ConnectWise Manage system.

## SYNTAX

Remove-CWMTimesheet [-TimesheetID] <Int32> [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]

## DESCRIPTION
The `Remove-CWMTimesheet` cmdlet allows you to delete a specific timesheet from the ConnectWise Manage system using the timesheet's unique ID. This operation is irreversible, so use it with caution. The cmdlet supports confirmation prompts and `-WhatIf` functionality to provide a safe way to see what would happen before actually executing the removal.

## EXAMPLES

### Example 1
PS C:\> Remove-CWMTimesheet -TimesheetID 123
Removes the timesheet with ID 123 from the system. You will be prompted to confirm the removal before the action is completed.

### Example 2
PS C:\> Remove-CWMTimesheet -TimesheetID 123 -Force
Removes the timesheet with ID 123 without any confirmation prompt.

### Example 3
PS C:\> Remove-CWMTimesheet -TimesheetID 123 -WhatIf
Displays what would happen if the cmdlet is run without actually removing the timesheet.

## PARAMETERS

### -TimesheetID
Specifies the ID of the timesheet to be removed. This parameter is mandatory.

Type: Int32
Parameter Sets: (All)
Aliases: tsID

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False

### -Force
If specified, bypasses the confirmation prompt and immediately removes the timesheet.

Type: SwitchParameter
Parameter Sets: (All)
Aliases: None

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False

### -WhatIf
Shows what would happen if the cmdlet runs. The cmdlet is not run.

Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False

### -Confirm
Prompts you for confirmation before running the cmdlet.

Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
Returns a confirmation message upon successful removal of the timesheet.

## NOTES

Use this cmdlet with caution as the deletion of timesheets cannot be undone.

## RELATED LINKS
[ConnectWise Manage API Documentation - Timesheets DELETE](https://developer.connectwise.com/Products/Manage/REST?a=Time&e=Timesheets&o=DELETE)
