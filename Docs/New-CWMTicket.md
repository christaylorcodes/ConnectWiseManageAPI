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
The id property of the request body.
Usually left unset; ConnectWise Manage assigns the id of a new
record.

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
Record type.
One of: ProjectIssue, ProjectTicket, ServiceTicket.

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
Site reference, for example @{ id = 5 }.

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
Site name.
Max length 156.

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
Address line 1.
Max length 50.

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
Address line 2.
Max length 50.

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
City.
Max length 50.

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
State identifier.
Max length 50.

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
Zip.
Max length 12.

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
Country reference, for example @{ id = 1 }.

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
Contact name.
Max length 62.

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
Contact phone number.
Max length 20.

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
Contact phone extension.
Max length 15.

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
Contact email address.
Max length 250.

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
Team reference, for example @{ id = 1 }.

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
Owner reference, for example @{ id = 1 }.

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
Service location reference, for example @{ id = 1 }.

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
Source reference, for example @{ id = 1 }.

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
Required date.
Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

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
Budget hours.
A number.

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
Opportunity reference, for example @{ id = 75 }.

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
Agreement reference, for example @{ id = 30 }.

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
Severity.
One of: Low, Medium, High.
Required on updates.

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
Impact.
One of: Low, Medium, High.
Required on updates.

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
External XRef.
Max length 100.

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
PO number.
Max length 50.

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
Knowledge base category id.
An integer.

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
Knowledge base sub category id.
An integer.

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
Allow all clients portal view.
$true or $false.

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
Customer updated flag.
$true or $false.

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
Automatic email contact flag.
$true or $false.

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
Automatic email resource flag.
$true or $false.

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
Automatic email CC flag.
$true or $false.

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
Automatic email CC.
Max length 1000.

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
Contact email lookup.

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
Process notifications.
$true or $false.
Can be set to false to skip notification processing when adding
or updating a ticket (Defaults to True).

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
Skip callback.
$true or $false.

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
Closed date.

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
Closed by.

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
Closed flag.
$true or $false.

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
Actual hours.
A number.

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
Approved.
$true or $false.

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
Estimated expense cost.
A number.

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
Estimated expense revenue.
A number.

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
Estimated product cost.
A number.

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
Estimated product revenue.
A number.

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
Estimated time cost.
A number.

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
Estimated time revenue.
A number.

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
Billing method.
One of: ActualRates, FixedFee, NotToExceed, OverrideRate.

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
Billing amount.
A number.

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
Hourly rate.
A number.

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
Sub billing method.
One of: ActualRates, FixedFee, NotToExceed, OverrideRate.

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
Sub billing amount.
A number.

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
Sub date accepted.

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
Date resolved.

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
Date resplan.

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
Date responded.

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
Resolve minutes.
An integer.
To obtain the current SLA times for an active ticket, please use the
/service/tickets/calculateSLA endpoint for multiple tickets or /service/tickets/{id} for individual
tickets.

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
Res plan minutes.
An integer.
To obtain the current SLA times for an active ticket, please use the
/service/tickets/calculateSLA endpoint for multiple tickets or /service/tickets/{id} for individual
tickets.

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
Respond minutes.
An integer.
To obtain the current SLA times for an active ticket, please use the
/service/tickets/calculateSLA endpoint for multiple tickets or /service/tickets/{id} for individual
tickets.

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
Is in SLA.
$true or $false.

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
Knowledge base link id.
An integer.

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
Resources.

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
Parent ticket id.
An integer.

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
Has child ticket.
$true or $false.

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
Has merged child ticket flag.
$true or $false.

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
Knowledge base link type.
One of: Activity, ProjectIssue, KnowledgeBaseArticle, ProjectTicket,
ServiceTicket, Time.

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
Bill time.
One of: Billable, DoNotBill, NoCharge, NoDefault.

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
Bill expenses.
One of: Billable, DoNotBill, NoCharge, NoDefault.

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
Bill products.
One of: Billable, DoNotBill, NoCharge, NoDefault.

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
Predecessor type.
One of: Ticket, Phase.

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
Predecessor id.
An integer.

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
Predecessor closed flag.
$true or $false.

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
Lag days.
An integer.

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
Lag nonworking days flag.
$true or $false.

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
Estimated start date.
Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

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
Duration.
An integer.

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
Location reference, for example @{ id = 1 }.

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
Department reference, for example @{ id = 1 }.

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
Mobile GUID.

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
SLA reference, for example @{ id = 1 }.

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
Currency reference, for example @{ id = 1 }.

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
Merged parent ticket reference, for example @{ id = 1 }.

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
Integrator tags.
An array of strings.

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
The _info metadata of the record, as returned by the API.
Usually left unset.

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
Custom fields.
An array of custom field values, for example @(@{ id = 4; value = 'Gold' }).

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

