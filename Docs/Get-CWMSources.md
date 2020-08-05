---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/Products/Manage/REST?#/Sources/getServiceSources
schema: 2.0.0
---

# Get-CWMSources

## SYNOPSIS
This function will list service sources on conditions.

## SYNTAX

```
Get-CWMSources [[-Condition] <String>] [[-orderBy] <Object>] [[-childconditions] <String>]
 [[-customfieldconditions] <String>] [[-page] <Int32>] [[-pageSize] <Int32>] [[-fields] <String[]>] [-all]
 [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
Get-CWMSources -Condition 'name like "*Phone*"'
```

Will return all priorities that include the word "Phone", such as "Phone Source"

## PARAMETERS

### -Condition
This is your search condition to return the results you desire.
Example:
(contact/name like "Fred%" and closedFlag = false) and dateEntered \> \[2015-12-23T05:53:27Z\] or summary contains "test" AND  summary != "Some Summary"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -orderBy
Choose which field to sort the results by

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -childconditions
Allows searching arrays on endpoints that list childConditions under parameters

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customfieldconditions
Allows searching custom fields when customFieldConditions is listed in the parameters

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -page
Used in pagination to cycle through results

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -pageSize
Number of results returned per page (Defaults to 25)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -fields
{{ Fill fields Description }}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -all
Return all results

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

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
Author: Michael Clark (@ClarkMichaelA)
Date: 03/10/2020

## RELATED LINKS

[https://developer.connectwise.com/Products/Manage/REST?#/Sources/getServiceSources](https://developer.connectwise.com/Products/Manage/REST?#/Sources/getServiceSources)

