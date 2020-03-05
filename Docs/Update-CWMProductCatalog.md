---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Update-CWMProductCatalog

## SYNOPSIS
This will update a catalog item.

## SYNTAX

```
Update-CWMProductCatalog [-CatalogID] <Object> [-Operation] <String> [-Path] <Object> [-Value] <Object>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
$Update = @{
```

CatalogID = $testProduct.id     Operation = 'replace'     Path      = 'price'     Value     = $Price } Update-CWMCatalog @Update

## PARAMETERS

### -CatalogID
The ID of the catalog that you are updating.
Get-CWMCatalogs

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Operation
What you are doing with the value.
replace

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
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
The value of that operation.

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
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Chris Taylor Date: 10/10/2018

## RELATED LINKS

[https://developer.connectwise.com/manage/rest?a=Procurement&e=CatalogsItem&o=UPDATE](https://developer.connectwise.com/manage/rest?a=Procurement&e=CatalogsItem&o=UPDATE)

