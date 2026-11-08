---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# Update-CWMAgreementAddition

## SYNOPSIS
Updates an addition to an agreement in ConnectWise Manage.

## SYNTAX

### Single (Default)
```
Update-CWMAgreementAddition [-parentId] <Int32> [-id] <Int32> [-Operation] <String> [-Path] <String>
 [[-Value] <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Bulk
```
Update-CWMAgreementAddition [-parentId] <Int32> [-id] <Int32> -PatchOperations <Object[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Applies JSON Patch operations to an existing agreement addition.
Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

This function calls the ConnectWise Manage API endpoint: PATCH /finance/agreements/{parentId}/additions/{id}

## EXAMPLES

### EXAMPLE 1
```
Update-CWMAgreementAddition -parentId 300 -id 25 -Operation replace -Path 'quantity' -Value 10
```

Sets the quantity of addition 25 of agreement 300 to 10.

### EXAMPLE 2
```
Update-CWMAgreementAddition 300 25 replace quantity 10
```

The same change, using positional parameters.

### EXAMPLE 3
```
Update-CWMAgreementAddition -parentId 300 -id 25 -PatchOperations @(
    @{ op = 'replace'; path = 'quantity'; value = 10 }
    @{ op = 'replace'; path = 'unitPrice'; value = 12.5 }
)
```

Changes the quantity and unit price of addition 25 in one request.

## PARAMETERS

### -parentId
The ID of the agreement.
Alias: agreementId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: agreementId

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
The ID of the addition to update.
Alias: additionId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: additionId

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Operation
The patch operation to perform: 'add', 'replace' or 'remove'.

```yaml
Type: System.String
Parameter Sets: Single
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
The property to change, for example 'quantity'.

```yaml
Type: System.String
Parameter Sets: Single
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
The new value for the property.
Required for 'add' and 'replace'; not needed for 'remove'.
Use -Value $null to set a property to null.

```yaml
Type: System.Object
Parameter Sets: Single
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PatchOperations
Several patch operations to apply in one request.
Each is a hashtable or PSCustomObject with
op, path and (except for 'remove') value.
'value' is left out of 'remove' operations.

```yaml
Type: System.Object[]
Parameter Sets: Bulk
Aliases:

Required: True
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

### PSCustomObject
### Returns the updated agreement addition.
## NOTES

## RELATED LINKS

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

