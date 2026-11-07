---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMServiceTemplateResource

## SYNOPSIS
Assigns a resource to a service template in ConnectWise Manage.

## SYNTAX

```
New-CWMServiceTemplateResource [-parentId] <Int32> [[-serviceTemplate] <Hashtable>] [[-member] <Hashtable>]
 [[-startDateTime] <String>] [[-endDateTime] <String>] [[-hours] <Double>] [[-scheduleStatus] <Hashtable>]
 [[-location] <Hashtable>] [[-reminderFlag] <Boolean>] [[-reminderMinutes] <Int32>]
 [[-isTicketOwner] <Boolean>] [[-timeZone] <Hashtable>] [[-endAfter] <Int32>] [[-recurrence] <Hashtable>]
 [[-_info] <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Assigns a resource (member) to a service template.

This function calls the ConnectWise Manage API endpoint: POST /service/templates/{parentId}/resources

## EXAMPLES

### EXAMPLE 1
```
New-CWMServiceTemplateResource -parentId 15 -member @{ identifier = 'jdoe' } -isTicketOwner $true
```

Assigns member jdoe to service template 15 as the ticket owner.

### EXAMPLE 2
```
New-CWMServiceTemplateResource -templateId 15 -member @{ id = 140 } -hours 2 -WhatIf
```

Shows the request that would be sent without creating anything.

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

### -serviceTemplate
The service template reference, e.g.
@{ id = 15 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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
Position: 3
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
Position: 4
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
Position: 5
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
Position: 6
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
Position: 7
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
Position: 8
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
Position: 9
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
Position: 10
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
Position: 11
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
Position: 12
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
Position: 13
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
Position: 14
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
Position: 15
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
### Returns the created service template resource.
## NOTES
Endpoint: POST /service/templates/{parentId}/resources

Based on PR #82 by mdewart-Centre.

## RELATED LINKS

[Get-CWMServiceTemplateResource]()

[Set-CWMServiceTemplateResource]()

[Update-CWMServiceTemplateResource]()

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

