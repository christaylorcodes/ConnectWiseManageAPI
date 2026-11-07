---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMProjectTicket

## SYNOPSIS
Creates a new project ticket in ConnectWise Manage.

## SYNTAX

```
New-CWMProjectTicket [-summary] <String> [-project] <Hashtable> [[-phase] <Hashtable>] [[-wbsCode] <String>]
 [[-board] <Hashtable>] [[-status] <Hashtable>] [[-company] <Hashtable>] [[-site] <Hashtable>]
 [[-contact] <Hashtable>] [[-contactName] <String>] [[-contactPhoneNumber] <String>]
 [[-contactEmailAddress] <String>] [[-type] <Hashtable>] [[-subType] <Hashtable>] [[-item] <Hashtable>]
 [[-priority] <Hashtable>] [[-owner] <Hashtable>] [[-serviceLocation] <Hashtable>] [[-source] <Hashtable>]
 [[-agreement] <Hashtable>] [[-requiredDate] <String>] [[-budgetHours] <Decimal>]
 [[-estimatedStartDate] <String>] [[-billTime] <String>] [[-billExpenses] <String>] [[-billProducts] <String>]
 [[-workRole] <Hashtable>] [[-workType] <Hashtable>] [[-location] <Hashtable>] [[-department] <Hashtable>]
 [[-initialDescription] <String>] [[-initialInternalAnalysis] <String>] [[-initialResolution] <String>]
 [[-customFields] <Hashtable[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a ticket on a project.
summary and project are required; other fields are optional
and use system defaults when not specified.
Use -phase to place the ticket on a project phase.

The fields mirror the service ticket model (New-CWMTicket) restricted to a conservative
subset; the full project ticket schema could not be checked against the ConnectWise API
documentation.
Any field not listed here can still be set afterwards with
Update-CWMProjectTicket.

This function calls the ConnectWise Manage API endpoint: POST /project/tickets

## EXAMPLES

### EXAMPLE 1
```
New-CWMProjectTicket -summary 'Migrate file shares' -project @{id=386} -phase @{id=12}
```

Creates a project ticket on phase 12 of project 386.
The API requires summary and phase.

### EXAMPLE 2
```
$Ticket = @{
    summary            = 'Configure backups'
    project            = @{ id = 386 }
    phase              = @{ id = 12 }
    budgetHours        = 4
    initialDescription = 'Set up nightly backups for the new servers.'
}
New-CWMProjectTicket @Ticket
```

Creates a project ticket on phase 12 of project 386 with a 4 hour budget.

## PARAMETERS

### -summary
The ticket summary/title (required).
Maximum 100 characters.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -project
Reference to the project the ticket belongs to (required).
Format: @{ id = 386 }

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -phase
Reference to the project phase.
Format: @{ id = 12 }

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

### -wbsCode
The work breakdown structure code.
Maximum 50 characters.

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

### -board
Reference to the project board.
Format: @{ id = 5 }

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -status
Reference to the status.
Format: @{ id = 456 }

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -company
Reference to the company.
Format: @{ id = 250 }

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

### -site
Reference to the company site.
Format: @{ id = 10 }

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

### -contact
Reference to the contact.
Format: @{ id = 789 }

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

### -contactName
The contact's name.
Maximum 62 characters.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -contactPhoneNumber
The contact's phone number.
Maximum 20 characters.

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

### -contactEmailAddress
The contact's email address.
Maximum 250 characters.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
Reference to the ticket type.
Format: @{ id = 100 }

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

### -subType
Reference to the ticket subtype.
Format: @{ id = 200 }

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

### -item
Reference to the ticket item.
Format: @{ id = 50 }

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

### -priority
Reference to the priority.
Format: @{ id = 3 }

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

### -owner
Reference to the owning member.
Format: @{ id = 150 }

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serviceLocation
Reference to the service location.
Format: @{ id = 1 }

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -source
Reference to the ticket source.
Format: @{ id = 2 }

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -agreement
Reference to the agreement.
Format: @{ id = 30 }

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -requiredDate
The date the ticket is required by, as an ISO 8601 string, e.g.
'2026-12-01T00:00:00Z'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -budgetHours
The budgeted hours for the ticket.

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedStartDate
The estimated start date, as an ISO 8601 string.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billTime
How time on the ticket is billed.
Passed to the API as-is.

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

### -billExpenses
How expenses on the ticket are billed.
Passed to the API as-is.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billProducts
How products on the ticket are billed.
Passed to the API as-is.

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

### -workRole
Default work role for time on the ticket, as a reference.
Format: @{ id = 2 }

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

### -workType
Default work type for time on the ticket, as a reference.
Format: @{ id = 3 }

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 28
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -location
The system location (SystemLocationReference).
Format: @{ id = 1 }

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 29
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -department
The department, also called business unit (SystemDepartmentReference).
Format: @{ id = 10 }

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -initialDescription
The initial description of the ticket.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 31
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -initialInternalAnalysis
Initial internal analysis notes (not visible to contacts).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 32
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -initialResolution
Initial resolution notes.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 33
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customFields
Array of custom field hashtables.
Format: @(@{ id = 1; value = 'x' })

```yaml
Type: System.Collections.Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 34
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
Parameters are properties of the ProjectTicket schema (POST /project/tickets), checked
against the ConnectWise OpenAPI spec 2026.11.
Only a commonly used subset is exposed.

## RELATED LINKS

[Get-CWMProjectTicket]()

[Update-CWMProjectTicket]()

[New-CWMTicket]()

[https://developer.connectwise.com/Products/ConnectWise_PSA/REST](https://developer.connectwise.com/Products/ConnectWise_PSA/REST)

