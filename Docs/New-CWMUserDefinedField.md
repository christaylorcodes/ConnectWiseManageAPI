---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# New-CWMUserDefinedField

## SYNOPSIS
Creates a user defined (custom) field.

## SYNTAX

```
New-CWMUserDefinedField [[-id] <Int32>] [-podId] <Int32> [[-podDescription] <String>] [-caption] <String>
 [-sequenceNumber] <Int32> [[-screenId] <String>] [[-screenDescription] <String>] [[-helpText] <String>]
 [-fieldTypeIdentifier] <String> [[-numberDecimals] <Int32>] [[-entryTypeIdentifier] <String>]
 [[-requiredFlag] <Boolean>] [[-displayOnScreenFlag] <Boolean>] [[-readOnlyFlag] <Boolean>]
 [[-listViewFlag] <Boolean>] [[-buttonUrl] <String>] [[-options] <Array>] [[-businessUnitIds] <Array>]
 [[-locationIds] <Array>] [[-addAllBusinessUnits] <Boolean>] [[-removeAllBusinessUnits] <Boolean>]
 [[-addAllLocations] <Boolean>] [[-removeAllLocations] <Boolean>] [[-connectWiseID] <String>]
 [[-displayScreenInASIO] <Boolean>] [[-dateCreated] <String>] [[-_info] <Hashtable>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a user defined (custom) field in ConnectWise Manage.
Calls POST /system/userDefinedFields; only the
parameters you pass are sent in the request body.

## EXAMPLES

### EXAMPLE 1
```
New-CWMUserDefinedField -podId 1 -caption 'Contract Ref' -sequenceNumber 10 -fieldTypeIdentifier Text -entryTypeIdentifier EntryField
```

Creates a text custom field on pod 1.

## PARAMETERS

### -id
The id property of the request body.
Usually left unset; ConnectWise Manage assigns the id of a new record.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -podId
Pod id.
A whole number.
Required by the API.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -podDescription
Pod description.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -caption
Caption.
Required by the API.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sequenceNumber
Sequence number.
A whole number.
Required by the API.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -screenId
Screen id.

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

### -screenDescription
Screen description.

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

### -helpText
Help text.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -fieldTypeIdentifier
Field type identifier.
One of: TextArea, Button, Currency, Date, Hyperlink, IPAddress, Checkbox, Number, Percent, PhoneNumber, Text, Password.
Required by the API.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -numberDecimals
Number decimals.
A whole number.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -entryTypeIdentifier
Entry type identifier.
One of: Date, EntryField, List, Option.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -requiredFlag
Required flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -displayOnScreenFlag
Display on screen flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -readOnlyFlag
Read only flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -listViewFlag
List view flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -buttonUrl
Button url.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -options
Options.
An array of objects.

```yaml
Type: System.Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -businessUnitIds
Business unit ids.
An array of ids, for example @(1, 2).

```yaml
Type: System.Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -locationIds
Location ids.
An array of ids, for example @(1, 2).

```yaml
Type: System.Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -addAllBusinessUnits
Add all business units.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -removeAllBusinessUnits
Remove all business units.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -addAllLocations
Add all locations.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -removeAllLocations
Remove all locations.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -connectWiseID
Connect wise id.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -displayScreenInASIO
Display screen in asio.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -dateCreated
Date created.
Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -_info
The _info metadata of the record, as returned by the API.
Usually left unset.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
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

## RELATED LINKS

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

