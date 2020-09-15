---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Update-CWMCompanyTypeAssociation

## SYNOPSIS
This will update a company type association.

## SYNTAX

```
Update-CWMCompanyTypeAssociation [-CompanyID] <Int32> [-TypeAssociationID] <Int32> [-Operation] <String>
 [-Path] <String> [-Value] <Object> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This will update a company type association.

## EXAMPLES

### EXAMPLE 1
```powershell
$UpdateParam = @{
    CompanyID = $Company.id
    TypeAssociationID = $TypeAssoc.id
    Operation = 'replace'
    Path = 'type/id'
    Value = $Type.id
}
Update-CWMCompanyTypeAssociation @UpdateParam
```

Will replace the `$TypeAssoc.id` with the new type associated with the id in `$Type.id`

## PARAMETERS

### -CompanyID
The ID of the company that you are updating.

`Get-CWMCompanies`

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: 0
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

`replace`

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: add, replace, remove

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
The value that you want to perform the operation on.

`type/id`

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TypeAssociationID
The TypeAssociationID you are updating.

`Get-CWMCompanyTypeAssociation -Company $Company.id`

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
The ID of the new type.

`Get-CWMCompanyType`

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
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
Author: Chris Taylor

Date: 10/10/2018

## RELATED LINKS

[https://developer.connectwise.com/Products/Manage/REST?a=Company&e=CompanyCompanyTypeAssociations&o=UPDATE](https://developer.connectwise.com/Products/Manage/REST?a=Company&e=CompanyCompanyTypeAssociations&o=UPDATE)

