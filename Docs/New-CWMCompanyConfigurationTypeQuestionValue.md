---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMCompanyConfigurationTypeQuestionValue

## SYNOPSIS
Adds an allowed value to a question on a configuration TYPE.

## SYNTAX

```
New-CWMCompanyConfigurationTypeQuestionValue [-grandparentId] <Int32> [-parentId] <Int32> [[-id] <Int32>]
 [[-configurationType] <Hashtable>] [[-defaultFlag] <Boolean>] [[-inactiveFlag] <Boolean>]
 [[-question] <Hashtable>] [-value] <String> [[-_info] <Hashtable>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new predefined value (for example a dropdown option) on a question of a
configuration type.
This changes the configuration type's definition, so the new option is
offered on every configuration of that type.

This function does NOT answer a question on a specific configuration.
To set a
configuration's answer, use Update-CWMCompanyConfiguration and replace its 'questions'
(see the examples).

The IDs map onto the URL like this:
/company/configurations/types/{grandparentId}/questions/{parentId}/values

This function calls the ConnectWise Manage API endpoint:
POST /company/configurations/types/{typeId}/questions/{questionId}/values

## EXAMPLES

### EXAMPLE 1
```
New-CWMCompanyConfigurationTypeQuestionValue -typeId 12 -questionId 431 -value 'Windows Server 2025'
```

Adds 'Windows Server 2025' as a new option for question 431 on configuration type 12.

### EXAMPLE 2
```
Update-CWMCompanyConfiguration -id 5501 -Operation replace -Path questions -Value @(@{ questionId = 431; answer = 'Windows Server 2025' })
```

The correct way to set the answer to question 431 on configuration 5501.
Use this, not
New-CWMCompanyConfigurationTypeQuestionValue, to fill in a configuration's answers.

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
The ID of the value record.
Normally left out; the server assigns it.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -configurationType
Reference to the configuration type.
Format: @{ id = 12 }

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -defaultFlag
Whether this value is the question's default.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -inactiveFlag
Whether this value is inactive.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -question
Reference to the question.
Format: @{ id = 431 }

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -value
The text of the allowed value (1-1000 characters).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -_info
Metadata hashtable passed through to the API as-is.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
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

[Update-CWMCompanyConfigurationTypeQuestionValue]()

[Update-CWMCompanyConfiguration]()

[https://developer.connectwise.com/Products/ConnectWise_PSA/REST](https://developer.connectwise.com/Products/ConnectWise_PSA/REST)

