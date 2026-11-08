---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Update-CWMCompanyConfigurationTypeQuestionValue

## SYNOPSIS
Updates an allowed value of a question on a configuration TYPE.

## SYNTAX

### Single (Default)
```
Update-CWMCompanyConfigurationTypeQuestionValue [-grandparentId] <Int32> [-parentId] <Int32> [-id] <Int32>
 [-Operation] <String> [-Path] <String> [[-Value] <Object>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### Bulk
```
Update-CWMCompanyConfigurationTypeQuestionValue [-grandparentId] <Int32> [-parentId] <Int32> [-id] <Int32>
 -PatchOperations <Object[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Edits one of the predefined values (for example a dropdown option) that a question on a
configuration type offers.
This changes the configuration type's definition, so it affects
every configuration of that type.

This function does NOT set the answer to a question on a specific configuration.
Passing a
configuration ID or an answer ID as -id results in a 404, because those IDs do not exist
under this endpoint.
To set a configuration's answer, use Update-CWMCompanyConfiguration
and replace its 'questions' (see the examples).

The IDs map onto the URL like this:
/company/configurations/types/{grandparentId}/questions/{parentId}/values/{id}

This function calls the ConnectWise Manage API endpoint:
PATCH /company/configurations/types/{typeId}/questions/{questionId}/values/{valueId}

## EXAMPLES

### EXAMPLE 1
```
Update-CWMCompanyConfigurationTypeQuestionValue -typeId 12 -questionId 431 -valueId 3 -Operation replace -Path value -Value 'Windows Server 2022'
```

Renames dropdown option 3 of question 431 on configuration type 12.
Every configuration
of type 12 will offer the new text.

### EXAMPLE 2
```
Update-CWMCompanyConfigurationTypeQuestionValue -typeId 12 -questionId 431 -valueId 3 -PatchOperations @(
    @{ op = 'replace'; path = 'value'; value = 'Windows Server 2022' }
    @{ op = 'replace'; path = 'defaultFlag'; value = $true }
)
```

Renames dropdown option 3 and makes it the default option, in one request.

### EXAMPLE 3
```
Update-CWMCompanyConfiguration -id 5501 -Operation replace -Path questions -Value @(@{ questionId = 431; answer = 'contoso.onmicrosoft.com' })
```

The correct way to set the answer to question 431 on configuration 5501.
Use this, not
Update-CWMCompanyConfigurationTypeQuestionValue, to fill in a configuration's answers.

## PARAMETERS

### -grandparentId
The ID of the configuration TYPE that owns the question (alias: typeId).
This is not a configuration ID.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: typeId

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -parentId
The ID of the question on that configuration type (alias: questionId).

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: questionId

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
The ID of the allowed value to update (alias: valueId).
This is the id of an entry
returned by GET /company/configurations/types/{typeId}/questions/{questionId}/values.
It is not a configuration ID or an answer ID.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: valueId

Required: True
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Operation
The patch operation: 'add', 'replace' or 'remove'.

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

### -Path
The property of the value to change, for example 'value', 'defaultFlag' or 'inactiveFlag'.

```yaml
Type: System.String
Parameter Sets: Single
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
The new value for the property named in -Path.
Required for 'add' and 'replace'; not needed
for 'remove'.
Use -Value $null to set the property to null.

```yaml
Type: System.Object
Parameter Sets: Single
Aliases:

Required: False
Position: 6
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

## NOTES

## RELATED LINKS

[New-CWMCompanyConfigurationTypeQuestionValue]()

[Update-CWMCompanyConfiguration]()

[https://developer.connectwise.com/Products/ConnectWise_PSA/REST](https://developer.connectwise.com/Products/ConnectWise_PSA/REST)

