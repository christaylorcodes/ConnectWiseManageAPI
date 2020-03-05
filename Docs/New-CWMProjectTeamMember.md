---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMProjectTeamMember

## SYNOPSIS
This function will create a new ticket.

## SYNTAX

```
New-CWMProjectTeamMember [-ProjectID] <Int32> [[-id] <Int32>] [[-hours] <Decimal>] [-member] <Object>
 [-projectRole] <Object> [[-workRole] <Object>] [[-startDate] <String>] [[-endDate] <String>]
 [[-_info] <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
$Ticket = @{
```

'identifier' = $Product.offerName     'description' = $Product.offerName     'subcategory' = @{id = 152}     'type' = @{id = 47}     'customerDescription' = $Product.offerName     'cost' = $Product.unitPrice     'price' = $Price     'manufacturerPartNumber' = $Product.offerName     'manufacturer' = $Manufacturer     'productClass' = 'Agreement'     'taxableFlag' = $true } New-CWTicket @Ticket

## PARAMETERS

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

### -ProjectID
{{ Fill ProjectID Description }}

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

### -_info
{{ Fill _info Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -endDate
{{ Fill endDate Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -hours
{{ Fill hours Description }}

```yaml
Type: Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
{{ Fill id Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -member
{{ Fill member Description }}

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

### -projectRole
{{ Fill projectRole Description }}

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

### -startDate
{{ Fill startDate Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -workRole
{{ Fill workRole Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Chris Taylor Date: 8/22/2018

## RELATED LINKS

[https://developer.connectwise.com/products/manage/rest?a=Project&e=ProjectsTeamMembers&o=CREATE](https://developer.connectwise.com/products/manage/rest?a=Project&e=ProjectsTeamMembers&o=CREATE)

