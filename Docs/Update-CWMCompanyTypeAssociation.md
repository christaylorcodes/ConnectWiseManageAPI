---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# Update-CWMCompanyTypeAssociation

## SYNOPSIS
Updates a company type association in ConnectWise Manage.

## SYNTAX

### Single (Default)
```
Update-CWMCompanyTypeAssociation [-parentId] <Int32> [-id] <Int32> [-Operation] <String> [-Path] <String>
 [[-Value] <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Bulk
```
Update-CWMCompanyTypeAssociation [-parentId] <Int32> [-id] <Int32> -PatchOperations <Object[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Applies JSON Patch operations to an existing company type association.
Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

This function calls the ConnectWise Manage API endpoint: PATCH /company/companies/{parentId}/typeAssociations/{id}

## EXAMPLES

### EXAMPLE 1
```
Update-CWMCompanyTypeAssociation -parentId 250 -id 3 -Operation replace -Path 'type' -Value @{ id = 5 }
```

Changes type association 3 of company 250 to company type 5.

### EXAMPLE 2
```
Update-CWMCompanyTypeAssociation 250 3 replace type @{ id = 5 }
```

The same change, using positional parameters.

### EXAMPLE 3
```
Update-CWMCompanyTypeAssociation -parentId 250 -id 3 -PatchOperations @(
    @{ op = 'replace'; path = 'type'; value = @{ id = 5 } }
)
```

Sends the same change with -PatchOperations.
Add more operations to the array to change several properties in one request.

## PARAMETERS

### -parentId
The ID of the company.
Alias: companyId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: companyId

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
The ID of the company type association to update.
Alias: typeAssociationId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: typeAssociationId

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
The property to change, for example 'type'.

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
### Returns the updated company type association.
## NOTES

## RELATED LINKS

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

