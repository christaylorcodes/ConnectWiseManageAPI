---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMCallbackEntry

## SYNOPSIS
This function will create a new callback entry.

## SYNTAX

```
New-CWMCallbackEntry [[-id] <Int32>] [[-description] <String>] [-url] <String> [-objectId] <Int32>
 [-type] <String> [-level] <String> [[-memberId] <Int32>] [[-inactiveFlag] <Boolean>] [[-_info] <Hashtable>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
ConnectWise Manage callbacks are payloads of information that are similar to webhooks.  When a record is saved within ConnectWise Manage, a summarized payload is sent to a specified location.

## EXAMPLES

### EXAMPLE 1
```powershell
New-CWMCallbackEntry -level 'board' -objectid 63 -type 'ticket' -url 'http://christaylor.codes/webhook?id='
```

Create a new callback for all tickets on service board 63.

### EXAMPLE 2
```powershell
New-CWMCallbackEntry -level 'Status' -objectid 72 -type 'ticket' -url 'http://christaylor.codes/webhook?id='
```

Create a new callback for all tickets in status 63.

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
Metadata

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -description
This is used to label the callback's usage.

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

### -id
Don't use. The database record id of the callback, this is automatically assigned.

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

### -inactiveFlag
Used to determine if the callback is active and sending requests.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -level
The type of object you want to trigger on ticket, contact, opportunity, etc. [See associated table for all values.](https://developer.connectwise.com/Products/Manage/Developer_Guide#Callbacks_(Webhooks))

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -memberId
This is a read only value that shows who initially created the Callback.

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

### -objectId
The ObjectId should be the Id of whatever record (level) you are subscribing to. This should be set to 1 when using a level of Owner.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
This is the specific type of record such as Company, Ticket, Contact, etc... [See the associated table for all values.](https://developer.connectwise.com/Products/Manage/Developer_Guide#Callbacks_(Webhooks))

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -url
This is the URL ConnectWise Manage will send the GET payload to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Chris Taylor Date: 6/27/2019

## RELATED LINKS

[https://marketplace.connectwise.com/docs/redoc/manage/system.html#tag/CallbackEntries/paths/~1system~1callbacks/post](https://marketplace.connectwise.com/docs/redoc/manage/system.html#tag/CallbackEntries/paths/~1system~1callbacks/post)
[https://developer.connectwise.com/Products/Manage/Developer_Guide#Callbacks_(Webhooks)](https://developer.connectwise.com/Products/Manage/Developer_Guide#Callbacks_(Webhooks))
