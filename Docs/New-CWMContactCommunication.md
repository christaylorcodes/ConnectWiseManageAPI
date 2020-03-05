---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMContactCommunication

## SYNOPSIS
This function will create a new contact communication.

## SYNTAX

```
New-CWMContactCommunication [-id] <Int32> [[-contactId] <Int32>] [-type] <Hashtable> [-value] <String>
 [[-extension] <String>] [[-defaultFlag] <Boolean>] [[-mobileGuid] <Guid>] [[-_info] <Hashtable>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
New-CWMContactCommunication -id 7125 -type @{'name' = 'Private Email'} -value 'don't@email.me'
```

Will add a Private Email address to the contact with the id of 7125.

### EXAMPLE 2
```
New-CWMContactCommunication -id 7125 -type @{'id' = '2'} -value '6054756968' -extension 555 -defaultFlag $true
```

Will add a direct phone number with an extension to the contact with the id of 7125 and set it as the default communication method.

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
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -contactId
don't use?

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

### -defaultFlag
Set to $true if you want to set as the default contact method.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -extension
If your type is a phone number you can add an extension.

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

### -id
The id of the contact you want to update.

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

### -mobileGuid
don't use?

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
The type of communication you are adding.
You can add by name or id.
@{'id' = 5} or @{'name' = 'Pager'}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -value
The email or phone number you want to add.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Chris Taylor Date: 9/26/2019

## RELATED LINKS

[https://marketplace.connectwise.com/docs/redoc/manage/company.html#tag/ContactCommunications/paths/~1company~1contacts~1{id}~1communications/post](https://marketplace.connectwise.com/docs/redoc/manage/company.html#tag/ContactCommunications/paths/~1company~1contacts~1{id}~1communications/post)

