---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest#/Tickets
schema: 2.0.0
---

# New-CWMTicket

## SYNOPSIS
Creates a new service ticket in ConnectWise Manage.

## SYNTAX

```
New-CWMTicket [-id <Int32>] -summary <String> [-recordType <String>] [-board <Hashtable>] [-status <Hashtable>]
 -company <Hashtable> [-site <Hashtable>] [-siteName <String>] [-addressLine1 <String>]
 [-addressLine2 <String>] [-city <String>] [-stateIdentifier <String>] [-zip <String>] [-country <Hashtable>]
 [-contact <Hashtable>] [-contactName <String>] [-contactPhoneNumber <String>]
 [-contactPhoneExtension <String>] [-contactEmailAddress <String>] [-type <Hashtable>] [-subType <Hashtable>]
 [-item <Hashtable>] [-team <Hashtable>] [-owner <Hashtable>] [-priority <Hashtable>]
 [-serviceLocation <Hashtable>] [-source <Hashtable>] [-requiredDate <String>] [-budgetHours <Decimal>]
 [-opportunity <Hashtable>] [-agreement <Hashtable>] [-severity <String>] [-impact <String>]
 [-externalXRef <String>] [-poNumber <String>] [-knowledgeBaseCategoryId <Int32>]
 [-knowledgeBaseSubCategoryId <Int32>] [-allowAllClientsPortalView <Boolean>] [-customerUpdatedFlag <Boolean>]
 [-automaticEmailContactFlag <Boolean>] [-automaticEmailResourceFlag <Boolean>]
 [-automaticEmailCcFlag <Boolean>] [-automaticEmailCc <String>] [-initialDescription <String>]
 [-initialInternalAnalysis <String>] [-initialResolution <String>] [-contactEmailLookup <String>]
 [-processNotifications <Boolean>] [-skipCallback <Boolean>] [-closedDate <String>] [-closedBy <String>]
 [-closedFlag <Boolean>] [-actualHours <Decimal>] [-approved <Boolean>] [-estimatedExpenseCost <Decimal>]
 [-estimatedExpenseRevenue <Decimal>] [-estimatedProductCost <Decimal>] [-estimatedProductRevenue <Decimal>]
 [-estimatedTimeCost <Decimal>] [-estimatedTimeRevenue <Decimal>] [-billingMethod <String>]
 [-billingAmount <Decimal>] [-hourlyRate <Decimal>] [-subBillingMethod <String>] [-subBillingAmount <Decimal>]
 [-subDateAccepted <String>] [-dateResolved <String>] [-dateResplan <String>] [-dateResponded <String>]
 [-resolveMinutes <Int32>] [-resPlanMinutes <Int32>] [-respondMinutes <Int32>] [-isInSla <Boolean>]
 [-knowledgeBaseLinkId <Int32>] [-resources <String>] [-parentTicketId <Int32>] [-hasChildTicket <Boolean>]
 [-hasMergedChildTicketFlag <Boolean>] [-knowledgeBaseLinkType <String>] [-billTime <String>]
 [-billExpenses <String>] [-billProducts <String>] [-predecessorType <String>] [-predecessorId <Int32>]
 [-predecessorClosedFlag <Boolean>] [-lagDays <Int32>] [-lagNonworkingDaysFlag <Boolean>]
 [-estimatedStartDate <String>] [-duration <Int32>] [-location <Hashtable>] [-department <Hashtable>]
 [-mobileGuid <Guid>] [-sla <Hashtable>] [-currency <Hashtable>] [-mergedParentTicket <Hashtable>]
 [-integratorTags <String>] [-_info <Hashtable>] [-customFields <Hashtable[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new service ticket with the specified properties.
The module only requires
summary and company; any field you leave out is not sent, and ConnectWise Manage applies
its own defaults or validation.

This function calls the ConnectWise Manage API endpoint: POST /service/tickets

## EXAMPLES

### EXAMPLE 1
```
# Minimal ticket creation
$ticket = @{
    summary = "Password reset request"
    company = @{ id = 250 }
}
New-CWMTicket @ticket
```

Creates a basic ticket with just summary and company.

### EXAMPLE 2
```
# Full ticket with board, status, and description
$ticket = @{
    summary = "Server offline - urgent"
    company = @{ id = 250 }
    board = @{ id = 1 }
    status = @{ id = 10 }
    priority = @{ id = 3 }
    initialDescription = "Production server is not responding. Multiple users affected."
}
New-CWMTicket @ticket
```

Creates a detailed ticket with multiple properties.

### EXAMPLE 3
```
# Ticket with contact information
$ticketParams = @{
    summary = "Email not working"
    company = @{ id = 250 }
    contact = @{ id = 500 }
    contactPhoneNumber = "555-1234"
    contactEmailAddress = "user@company.com"
    initialDescription = "User reports unable to send/receive email."
}
New-CWMTicket @ticketParams
```

Creates a ticket with contact details.

## PARAMETERS

### -id
{{ Fill id Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -summary
The ticket summary/title (required).
1-100 characters (enforced by the parameter's ValidateLength).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -recordType
{{ Fill recordType Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -board
Hashtable with service board reference.
Format: @{ id = 1 }
If not specified, no board is sent and ConnectWise Manage decides the board.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -status
Hashtable with status reference.
Format: @{ id = 456 }
If not specified, no status is sent and ConnectWise Manage decides the status.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -company
Hashtable with company reference (required).
Format: @{ id = 123 }

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -site
{{ Fill site Description }}

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -siteName
{{ Fill siteName Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -addressLine1
{{ Fill addressLine1 Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -addressLine2
{{ Fill addressLine2 Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -city
{{ Fill city Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -stateIdentifier
{{ Fill stateIdentifier Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -zip
{{ Fill zip Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -country
{{ Fill country Description }}

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -contact
Hashtable with contact reference.
Format: @{ id = 789 }

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -contactName
{{ Fill contactName Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -contactPhoneNumber
{{ Fill contactPhoneNumber Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -contactPhoneExtension
{{ Fill contactPhoneExtension Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -contactEmailAddress
{{ Fill contactEmailAddress Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
Hashtable with type reference.
Format: @{ id = 100 }

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -subType
Hashtable with subtype reference.
Format: @{ id = 200 }

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -item
Hashtable with item reference.
Format: @{ id = 50 }

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -team
{{ Fill team Description }}

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -owner
{{ Fill owner Description }}

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -priority
Hashtable with priority reference.
Format: @{ id = 3 }

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serviceLocation
{{ Fill serviceLocation Description }}

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -source
{{ Fill source Description }}

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -requiredDate
{{ Fill requiredDate Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -budgetHours
{{ Fill budgetHours Description }}

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -opportunity
{{ Fill opportunity Description }}

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -agreement
{{ Fill agreement Description }}

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -severity
{{ Fill severity Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -impact
{{ Fill impact Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -externalXRef
{{ Fill externalXRef Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -poNumber
{{ Fill poNumber Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -knowledgeBaseCategoryId
{{ Fill knowledgeBaseCategoryId Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -knowledgeBaseSubCategoryId
{{ Fill knowledgeBaseSubCategoryId Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -allowAllClientsPortalView
{{ Fill allowAllClientsPortalView Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -customerUpdatedFlag
{{ Fill customerUpdatedFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -automaticEmailContactFlag
{{ Fill automaticEmailContactFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -automaticEmailResourceFlag
{{ Fill automaticEmailResourceFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -automaticEmailCcFlag
{{ Fill automaticEmailCcFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -automaticEmailCc
{{ Fill automaticEmailCc Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -initialDescription
The initial description/details for the ticket.
Supports HTML.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -initialInternalAnalysis
Internal analysis notes (not visible to contacts).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -contactEmailLookup
{{ Fill contactEmailLookup Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -processNotifications
{{ Fill processNotifications Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -skipCallback
{{ Fill skipCallback Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -closedDate
{{ Fill closedDate Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -closedBy
{{ Fill closedBy Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -closedFlag
{{ Fill closedFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -actualHours
{{ Fill actualHours Description }}

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -approved
{{ Fill approved Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedExpenseCost
{{ Fill estimatedExpenseCost Description }}

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedExpenseRevenue
{{ Fill estimatedExpenseRevenue Description }}

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedProductCost
{{ Fill estimatedProductCost Description }}

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedProductRevenue
{{ Fill estimatedProductRevenue Description }}

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedTimeCost
{{ Fill estimatedTimeCost Description }}

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedTimeRevenue
{{ Fill estimatedTimeRevenue Description }}

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingMethod
{{ Fill billingMethod Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingAmount
{{ Fill billingAmount Description }}

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -hourlyRate
{{ Fill hourlyRate Description }}

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -subBillingMethod
{{ Fill subBillingMethod Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -subBillingAmount
{{ Fill subBillingAmount Description }}

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -subDateAccepted
{{ Fill subDateAccepted Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -dateResolved
{{ Fill dateResolved Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -dateResplan
{{ Fill dateResplan Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -dateResponded
{{ Fill dateResponded Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -resolveMinutes
{{ Fill resolveMinutes Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -resPlanMinutes
{{ Fill resPlanMinutes Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -respondMinutes
{{ Fill respondMinutes Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -isInSla
{{ Fill isInSla Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -knowledgeBaseLinkId
{{ Fill knowledgeBaseLinkId Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -resources
{{ Fill resources Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -parentTicketId
{{ Fill parentTicketId Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -hasChildTicket
{{ Fill hasChildTicket Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -hasMergedChildTicketFlag
{{ Fill hasMergedChildTicketFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -knowledgeBaseLinkType
{{ Fill knowledgeBaseLinkType Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billTime
{{ Fill billTime Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billExpenses
{{ Fill billExpenses Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billProducts
{{ Fill billProducts Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -predecessorType
{{ Fill predecessorType Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -predecessorId
{{ Fill predecessorId Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -predecessorClosedFlag
{{ Fill predecessorClosedFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -lagDays
{{ Fill lagDays Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -lagNonworkingDaysFlag
{{ Fill lagNonworkingDaysFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedStartDate
{{ Fill estimatedStartDate Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -duration
{{ Fill duration Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -location
{{ Fill location Description }}

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -department
{{ Fill department Description }}

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mobileGuid
{{ Fill mobileGuid Description }}

```yaml
Type: System.Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sla
{{ Fill sla Description }}

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -currency
{{ Fill currency Description }}

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mergedParentTicket
{{ Fill mergedParentTicket Description }}

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -integratorTags
{{ Fill integratorTags Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -_info
{{ Fill _info Description }}

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customFields
{{ Fill customFields Description }}

```yaml
Type: System.Collections.Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
Author: Chris Taylor

Required Fields:
- summary (string, max 100 chars)
- company (hashtable with id)

Common Optional Fields:
- board, status, priority, type, subType, item
- contact, contactName, contactPhoneNumber, contactEmailAddress
- initialDescription, initialInternalAnalysis, initialResolution
- owner, team, serviceLocation, source

## RELATED LINKS

[https://developer.connectwise.com/manage/rest#/Tickets](https://developer.connectwise.com/manage/rest#/Tickets)

[Get-CWMTicket]()

[Update-CWMTicket]()

[Remove-CWMTicket]()

