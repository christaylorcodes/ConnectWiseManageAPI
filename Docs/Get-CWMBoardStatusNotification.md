---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# Get-CWMBoardStatusNotification

## SYNOPSIS
Gets the status notifications of a board status.

## SYNTAX

```
Get-CWMBoardStatusNotification [-grandparentId] <Int32> [-parentId] <Int32> [[-id] <Int32>] [-count]
 [[-condition] <String>] [[-orderBy] <String>] [[-childConditions] <String>]
 [[-customFieldConditions] <String>] [[-page] <Int32>] [[-pageSize] <Int32>] [[-fields] <String[]>] [-all]
 [<CommonParameters>]
```

## DESCRIPTION
Retrieves the status notifications of a board status from ConnectWise Manage, or a single status
notification by id.
Calls GET /service/boards/{grandparentId}/statuses/{parentId}/notifications; -id
adds /{id} and -count adds /count.

## EXAMPLES

### EXAMPLE 1
```
Get-CWMBoardStatusNotification -grandparentId 3 -parentId 12 -condition "member/identifier='jdoe'" -all
```

Retrieves the status notifications of board status 12 that match the condition.

### EXAMPLE 2
```
Get-CWMBoardStatusNotification -grandparentId 3 -parentId 12 -id 5
```

Retrieves status notification 5 of board status 12.

## PARAMETERS

### -grandparentId
The id of the service board.
Alias: boardId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: boardId

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -parentId
The id of the board status.
Alias: statusId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: statusId

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
The id of a single status notification to retrieve.

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

### -count
Return only the number of matching status notifications instead of the records.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -condition
Filter in ConnectWise Manage condition syntax, for example "member/identifier='jdoe'".

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -orderBy
Sort order as 'field asc' or 'field desc', for example 'id desc'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -childConditions
Filter on child (list) fields, in condition syntax.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customFieldConditions
Filter on custom field values, in condition syntax.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -page
The page number to return.
Use with -pageSize.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -pageSize
The number of records per page.
Without it the API's default page size applies.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -fields
Only return these fields, for example @('id', 'notifyWho').

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -all
Retrieve every matching record, handling pagination automatically.

```yaml
Type: System.Management.Automation.SwitchParameter
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

## RELATED LINKS

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

