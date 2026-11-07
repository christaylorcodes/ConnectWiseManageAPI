---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest#/Companies
schema: 2.0.0
---

# Update-CWMCompany

## SYNOPSIS
Updates an existing company in ConnectWise Manage using patch operations.

## SYNTAX

### Single (Default)
```
Update-CWMCompany [-id] <Int32> [-Operation] <String> [-Path] <String> [[-Value] <Object>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Bulk
```
Update-CWMCompany [-id] <Int32> -PatchOperations <Object[]> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Modifies company properties using JSON Patch operations (add, replace, remove).
This follows the RFC 6902 JSON Patch standard.
Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

This function calls the ConnectWise Manage API endpoint: PATCH /company/companies/{id}

## EXAMPLES

### EXAMPLE 1
```
Update-CWMCompany -id 250 -Operation 'replace' -Path 'name' -Value 'Acme Corporation Inc'
```

Updates the company name.

### EXAMPLE 2
```
Update-CWMCompany -id 250 -Operation 'replace' -Path 'phoneNumber' -Value '206-555-9999'
```

Updates the phone number.

### EXAMPLE 3
```
Update-CWMCompany -id 250 -Operation 'replace' -Path 'status' -Value @{ id = 1 }
```

Changes the company status.

### EXAMPLE 4
```
Update-CWMCompany -id 250 -PatchOperations @(
    @{ op = 'replace'; path = 'name'; value = 'Acme Corporation Inc' }
    @{ op = 'replace'; path = 'phoneNumber'; value = '206-555-9999' }
    @{ op = 'replace'; path = 'status'; value = @{ id = 1 } }
)
```

Changes the name, phone number and status of company 250 in one request.

## PARAMETERS

### -id
The company ID to update (required).
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

### -Operation
The patch operation: 'add', 'replace', or 'remove'.

```yaml
Type: System.String
Parameter Sets: Single
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
The field path to modify.
Examples: 'name', 'phoneNumber', 'status', 'addressLine1'

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

### -Value
The new value for the field (required for 'add' and 'replace'; not needed for 'remove').
Use -Value $null to set a field to null.

```yaml
Type: System.Object
Parameter Sets: Single
Aliases:

Required: False
Position: 4
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
Author: Chris Taylor

Common Update Paths:
- 'name', 'identifier'
- 'phoneNumber', 'faxNumber', 'website'
- 'addressLine1', 'city', 'state', 'zip'
- 'status', 'territory', 'types'

## RELATED LINKS

[https://developer.connectwise.com/manage/rest#/Companies](https://developer.connectwise.com/manage/rest#/Companies)

[Get-CWMCompany]()

[New-CWMCompany]()

[Remove-CWMCompany]()

