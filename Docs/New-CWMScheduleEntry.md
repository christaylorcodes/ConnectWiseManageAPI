---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMScheduleEntry

## SYNOPSIS
This function will create a new ticket.

## SYNTAX

```
New-CWMScheduleEntry [[-id] <Int32>] [[-objectId] <Int32>] [[-name] <String>] [-member] <Object>
 [[-where] <Object>] [[-dateStart] <String>] [[-dateEnd] <String>] [[-reminder] <Object>] [[-status] <Object>]
 [-type] <Object> [[-span] <Object>] [[-doneFlag] <Boolean>] [[-acknowledgedFlag] <Boolean>]
 [[-ownerFlag] <Boolean>] [[-meetingFlag] <Boolean>] [[-allowScheduleConflictsFlag] <Boolean>]
 [[-addMemberToProjectFlag] <Boolean>] [[-projectRoleId] <Int32>] [[-mobileGuid] <Guid>]
 [[-closeDate] <String>] [[-hours] <Decimal>] [[-_info] <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
$Ticket = @{
```

'identifier' = $Product.offerName     'description' = $Product.offerName     'subcategory' = @{id = 152}     'type' = @{id = 47}     'customerDescription' = $Product.offerName     'cost' = $Product.unitPrice     'price' = $Price     'manufacturerPartNumber' = $Product.offerName     'manufacturer' = $Manufacturer     'productClass' = 'Agreement'     'taxableFlag' = $true } New-CWMScheduleEntry @Ticket

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
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -acknowledgedFlag
{{ Fill acknowledgedFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -addMemberToProjectFlag
{{ Fill addMemberToProjectFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -allowScheduleConflictsFlag
{{ Fill allowScheduleConflictsFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -closeDate
{{ Fill closeDate Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -dateEnd
{{ Fill dateEnd Description }}

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

### -dateStart
{{ Fill dateStart Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -doneFlag
{{ Fill doneFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: False
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
Position: 20
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
Position: 0
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -meetingFlag
{{ Fill meetingFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: False
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

### -mobileGuid
{{ Fill mobileGuid Description }}

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -name
{{ Fill name Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -objectId
{{ Fill objectId Description }}

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

### -ownerFlag
{{ Fill ownerFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -projectRoleId
{{ Fill projectRoleId Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -reminder
{{ Fill reminder Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -span
{{ Fill span Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -status
{{ Fill status Description }}

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

### -type
{{ Fill type Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -where
{{ Fill where Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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

[https://developer.connectwise.com/products/manage/rest?a=Schedule&e=ScheduleEntries&o=CREATE](https://developer.connectwise.com/products/manage/rest?a=Schedule&e=ScheduleEntries&o=CREATE)

