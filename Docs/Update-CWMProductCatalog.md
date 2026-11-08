---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Update-CWMProductCatalog

## SYNOPSIS
Updates a product catalog item in ConnectWise Manage.

## SYNTAX

### Single (Default)
```
Update-CWMProductCatalog [-id] <Int32> [-Operation] <String> [-Path] <String> [[-Value] <Object>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Bulk
```
Update-CWMProductCatalog [-id] <Int32> -PatchOperations <Object[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Applies JSON Patch operations to an existing product catalog item.
Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

This function calls the ConnectWise Manage API endpoint: PATCH /procurement/catalog/{id}

## EXAMPLES

### EXAMPLE 1
```
Update-CWMProductCatalog -id 123 -Operation replace -Path 'price' -Value 49.99
```

Replaces the price of catalog item 123.

### EXAMPLE 2
```
Update-CWMProductCatalog 123 replace price 49.99
```

The same change, using positional parameters.

### EXAMPLE 3
```
Update-CWMProductCatalog -id 123 -PatchOperations @(
    @{ op = 'replace'; path = 'price'; value = 49.99 }
    @{ op = 'replace'; path = 'cost'; value = 30 }
    @{ op = 'replace'; path = 'description'; value = 'Updated description' }
)
```

Changes the price, cost and description of catalog item 123 in one request.

## PARAMETERS

### -id
The ID of the catalog item to update (required).
Alias: catalogId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: catalogId

Required: True
Position: 1
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
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
The catalog item property to change, for example 'description' or 'price'.

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
The new value for the property.
Required for 'add' and 'replace'; not needed for 'remove'.
Use -Value $null to set a property to null.

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

### PSCustomObject
### Returns the updated catalog item.
## NOTES
Endpoint: PATCH /procurement/catalog/{id}

-PatchOperations implements GitHub issue #53 (several changes in one request), based on PR #82 by mdewart-Centre.

## RELATED LINKS

[Get-CWMProductCatalog]()

[New-CWMProductCatalog]()

[https://github.com/christaylorcodes/ConnectWiseManageAPI/issues/53](https://github.com/christaylorcodes/ConnectWiseManageAPI/issues/53)

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

