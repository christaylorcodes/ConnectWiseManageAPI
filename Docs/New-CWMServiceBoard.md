---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# New-CWMServiceBoard

## SYNOPSIS
Creates a service board.

## SYNTAX

```
New-CWMServiceBoard [[-id] <Int32>] [-name] <String> [[-location] <Hashtable>] [[-department] <Hashtable>]
 [[-inactiveFlag] <Boolean>] [[-signOffTemplate] <Hashtable>] [[-sendToContactFlag] <Boolean>]
 [[-contactTemplate] <Hashtable>] [[-sendToResourceFlag] <Boolean>] [[-resourceTemplate] <Hashtable>]
 [[-projectFlag] <Boolean>] [[-showDependenciesFlag] <Boolean>] [[-showEstimatesFlag] <Boolean>]
 [[-boardIcon] <Hashtable>] [[-billTicketsAfterClosedFlag] <Boolean>] [[-billTicketSeparatelyFlag] <Boolean>]
 [[-billUnapprovedTimeExpenseFlag] <Boolean>] [[-overrideBillingSetupFlag] <Boolean>]
 [[-dispatchMember] <Hashtable>] [[-serviceManagerMember] <Hashtable>] [[-dutyManagerMember] <Hashtable>]
 [[-oncallMember] <Hashtable>] [[-workRole] <Hashtable>] [[-workType] <Hashtable>] [[-billTime] <String>]
 [[-billExpense] <String>] [[-billProduct] <String>] [[-autoCloseStatus] <Hashtable>]
 [[-autoAssignNewTicketsFlag] <Boolean>] [[-autoAssignNewECTicketsFlag] <Boolean>]
 [[-autoAssignNewPortalTicketsFlag] <Boolean>] [[-discussionsLockedFlag] <Boolean>]
 [[-timeEntryLockedFlag] <Boolean>] [[-notifyEmailFrom] <String>] [[-notifyEmailFromName] <String>]
 [[-closedLoopDiscussionsFlag] <Boolean>] [[-closedLoopResolutionFlag] <Boolean>]
 [[-closedLoopInternalAnalysisFlag] <Boolean>] [[-timeEntryDiscussionFlag] <Boolean>]
 [[-timeEntryResolutionFlag] <Boolean>] [[-timeEntryInternalAnalysisFlag] <Boolean>] [[-problemSort] <String>]
 [[-resolutionSort] <String>] [[-internalAnalysisSort] <String>]
 [[-emailConnectorAllowReopenClosedFlag] <Boolean>] [[-emailConnectorReopenStatus] <Hashtable>]
 [[-emailConnectorReopenResourcesFlag] <Boolean>] [[-emailConnectorNewTicketNoMatchFlag] <Boolean>]
 [[-emailConnectorNeverReopenByDaysFlag] <Boolean>] [[-emailConnectorReopenDaysLimit] <Int32>]
 [[-emailConnectorNeverReopenByDaysClosedFlag] <Boolean>] [[-emailConnectorReopenDaysClosedLimit] <Int32>]
 [[-useMemberDisplayNameFlag] <Boolean>] [[-sendToCCFlag] <Boolean>] [[-autoAssignTicketOwnerFlag] <Boolean>]
 [[-closedLoopAllFlag] <Boolean>] [[-percentageCalculation] <String>] [[-allSort] <String>]
 [[-markFirstNoteIssueFlag] <Boolean>] [[-_info] <Hashtable>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a service board in ConnectWise Manage.
Calls POST /service/boards; only the parameters you pass
are sent in the request body.

## EXAMPLES

### EXAMPLE 1
```
New-CWMServiceBoard -name 'Help Desk' -location @{ id = 1 } -department @{ id = 2 }
```

Creates a service board for location 1 and department 2.

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
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -name
Name.
Max length 50.
Required by the API.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -location
Location reference, for example @{ id = 1 }.
Required by the API.

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

### -department
Department reference, for example @{ id = 1 }.
Required by the API.

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

### -inactiveFlag
Inactive flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -signOffTemplate
Sign off template reference, for example @{ id = 1 }.

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

### -sendToContactFlag
Send to contact flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -contactTemplate
Contact template reference, for example @{ id = 1 }.

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

### -sendToResourceFlag
Send to resource flag.
$true or $false.

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

### -resourceTemplate
Resource template reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -projectFlag
Project flag.
$true or $false.

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

### -showDependenciesFlag
Show dependencies flag.
$true or $false.
This field only shows if it is Project Board.

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

### -showEstimatesFlag
Show estimates flag.
$true or $false.
This field only shows if it is Project Board.

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

### -boardIcon
Board icon reference, for example @{ id = 1 }.

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

### -billTicketsAfterClosedFlag
Bill tickets after closed flag.
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

### -billTicketSeparatelyFlag
Bill ticket separately flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -billUnapprovedTimeExpenseFlag
Bill unapproved time expense flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -overrideBillingSetupFlag
Override billing setup flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -dispatchMember
Dispatch member reference, for example @{ id = 1 }.

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

### -serviceManagerMember
Service manager member reference, for example @{ id = 1 }.

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

### -dutyManagerMember
Duty manager member reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -oncallMember
Oncall member reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -workRole
Work role reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -workType
Work type reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
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
Position: 25
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billExpense
Bill expense.
One of: Billable, DoNotBill, NoCharge, NoDefault.

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

### -billProduct
Bill product.
One of: Billable, DoNotBill, NoCharge, NoDefault.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -autoCloseStatus
Auto close status reference, for example @{ id = 1 }.

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

### -autoAssignNewTicketsFlag
Auto assign new tickets flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 29
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -autoAssignNewECTicketsFlag
Auto assign new EC tickets flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -autoAssignNewPortalTicketsFlag
Auto assign new portal tickets flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 31
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -discussionsLockedFlag
Discussions locked flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 32
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeEntryLockedFlag
Time entry locked flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 33
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -notifyEmailFrom
Notify email from.
Max length 50.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 34
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -notifyEmailFromName
Notify email from name.
Max length 60.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 35
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -closedLoopDiscussionsFlag
Closed loop discussions flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 36
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -closedLoopResolutionFlag
Closed loop resolution flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 37
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -closedLoopInternalAnalysisFlag
Closed loop internal analysis flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 38
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeEntryDiscussionFlag
Time entry discussion flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 39
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeEntryResolutionFlag
Time entry resolution flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 40
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeEntryInternalAnalysisFlag
Time entry internal analysis flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 41
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -problemSort
Problem sort.
One of: Ascending, Descending.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 42
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -resolutionSort
Resolution sort.
One of: Ascending, Descending.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 43
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -internalAnalysisSort
Internal analysis sort.
One of: Ascending, Descending.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 44
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailConnectorAllowReopenClosedFlag
Email connector allow reopen closed flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 45
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailConnectorReopenStatus
Email connector reopen status reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 46
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailConnectorReopenResourcesFlag
Email connector reopen resources flag.
$true or $false.
This field can only be set when
emailConnectorAllowReopenClosed is true.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 47
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailConnectorNewTicketNoMatchFlag
Email connector new ticket no match flag.
$true or $false.
This field can only be set when
emailConnectorAllowReopenClosed is true.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 48
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailConnectorNeverReopenByDaysFlag
Email connector never reopen by days flag.
$true or $false.
This field can only be set when
emailConnectorAllowReopenClosed is true.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 49
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailConnectorReopenDaysLimit
Email connector reopen days limit.
An integer.
This field can only be set when
emailConnectorNeverReopenByDaysFlag and emailConnectorAllowReopenClosed are both true This field is
required when emailConnectorNeverReopenByDaysFlag is true.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 50
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailConnectorNeverReopenByDaysClosedFlag
Email connector never reopen by days closed flag.
$true or $false.
This field can only be set when
emailConnectorAllowReopenClosed is true.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 51
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailConnectorReopenDaysClosedLimit
Email connector reopen days closed limit.
An integer.
This field can only be set when
emailConnectorNeverReopenByDaysClosedFlag and emailConnectorAllowReopenClosed are both true This field
is required when emailConnectorNeverReopenByDaysClosedFlag is true.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 52
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -useMemberDisplayNameFlag
Use member display name flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 53
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -sendToCCFlag
Send to CC flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 54
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -autoAssignTicketOwnerFlag
Auto assign ticket owner flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 55
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -closedLoopAllFlag
Closed loop all flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 56
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -percentageCalculation
Percentage calculation.
One of: ActualHours, Manual, ClosedPhases, ClosedTickets.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 57
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -allSort
All sort.
One of: Ascending, Descending.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 58
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -markFirstNoteIssueFlag
Mark first note issue flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 59
Default value: False
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
Position: 60
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

