---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Update-CWMTimeEntry

## SYNOPSIS
This will update a time entry.

## SYNTAX

```
Update-CWMTimeEntry -id <Int32> [-Operation] <String> [-Path] <String> [-Value] <Object> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
$UpdateParam = @{
    ID = 1
    Operation = 'replace'
    Path = 'name'
    Value = $NewName
}
Update-CWMTimeEntry @UpdateParam
```

### EXAMPLE 2
```powershell
$UpdateParam = @{
    ID = 1
    Operation = 'replace'
    Path = 'subType'
    Value = ${id = 123}
}
Update-CWMTimeEntry @UpdateParam
```

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

### -Operation
What you are doing with the value.
replace, add, remove

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: add, replace, remove

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
The value that you want to perform the operation on.

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

### -Value
The value of the path.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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

### -id
{{ Fill id Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: entryId

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

[https://developer.connectwise.com/Products/Manage/REST#/TimeEntries](https://developer.connectwise.com/Products/Manage/REST#/TimeEntries)