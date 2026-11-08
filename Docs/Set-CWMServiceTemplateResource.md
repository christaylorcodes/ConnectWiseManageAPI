---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Set-CWMServiceTemplateResource

## SYNOPSIS
Replaces a service template resource in ConnectWise Manage.

## SYNTAX

```
Set-CWMServiceTemplateResource [-parentId] <Int32> [-id] <Int32> [[-serviceTemplate] <Hashtable>]
 [[-member] <Hashtable>] [[-startDateTime] <String>] [[-endDateTime] <String>] [[-hours] <Double>]
 [[-scheduleStatus] <Hashtable>] [[-location] <Hashtable>] [[-reminderFlag] <Boolean>]
 [[-reminderMinutes] <Int32>] [[-isTicketOwner] <Boolean>] [[-timeZone] <Hashtable>] [[-endAfter] <Int32>]
 [[-recurrence] <Hashtable>] [[-_info] <Hashtable>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Replaces a whole service template resource (PUT).
Properties that are not specified may be
cleared by the API.
To change only some properties, use Update-CWMServiceTemplateResource.

This function calls the ConnectWise Manage API endpoint: PUT /service/templates/{parentId}/resources/{id}

## EXAMPLES

### EXAMPLE 1
```
Set-CWMServiceTemplateResource -parentId 15 -id 3 -member @{ identifier = 'jdoe' } -hours 1.5 -isTicketOwner $true
```

Replaces resource 3 of service template 15.

## PARAMETERS

### -parentId
The ID of the service template (required).
Alias: templateId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: templateId

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
The ID of the resource to replace (required).
Alias: resourceId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: resourceId

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -serviceTemplate
The service template reference, e.g.
@{ id = 15 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -member
The member reference, e.g.
@{ id = 140 } or @{ identifier = 'jdoe' }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -startDateTime
The start date and time, as an ISO 8601 string, e.g.
'2026-01-05T14:00:00Z'.

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

### -endDateTime
The end date and time, as an ISO 8601 string.

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

### -hours
The scheduled hours.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -scheduleStatus
The schedule status reference, e.g.
@{ id = 2 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -location
The schedule location reference, e.g.
@{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -reminderFlag
Sets reminderFlag.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -reminderMinutes
Sets reminderMinutes.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -isTicketOwner
Sets isTicketOwner.

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

### -timeZone
The time zone reference, e.g.
@{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -endAfter
Sets endAfter.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -recurrence
The recurrence object, passed through to the request body.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -_info
The _info metadata object, passed through to the request body.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
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
### Returns the replaced service template resource.
## NOTES
Endpoint: PUT /service/templates/{parentId}/resources/{id}

Based on PR #82 by mdewart-Centre.

## RELATED LINKS

[Get-CWMServiceTemplateResource]()

[Update-CWMServiceTemplateResource]()

[Invoke-CWMSetMaster]()

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

