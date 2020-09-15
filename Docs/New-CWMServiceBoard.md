---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMServiceBoard

## SYNOPSIS
This function will create a new service board.

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
 [[-markFirstNoteIssueFlag] <Boolean>] [[-_info] <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This function will create a new service board.

## EXAMPLES

### EXAMPLE 1
```powershell
New-CWMServiceBoard -name 'test' -location @{id=2} -department @{id=14}
```

this will create a new 'test' service board.

## PARAMETERS

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -_info
{{ Fill _info Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 59
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -allSort
{{ Fill allSort Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Ascending, Descending

Required: False
Position: 57
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -autoAssignNewECTicketsFlag
{{ Fill autoAssignNewECTicketsFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 29
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -autoAssignNewPortalTicketsFlag
{{ Fill autoAssignNewPortalTicketsFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -autoAssignNewTicketsFlag
{{ Fill autoAssignNewTicketsFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 28
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -autoAssignTicketOwnerFlag
{{ Fill autoAssignTicketOwnerFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 54
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -autoCloseStatus
{{ Fill autoCloseStatus Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billExpense
{{ Fill billExpense Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Billable, DoNotBill, NoCharge, NoDefault

Required: False
Position: 25
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billProduct
{{ Fill billProduct Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Billable, DoNotBill, NoCharge, NoDefault

Required: False
Position: 26
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billTicketSeparatelyFlag
{{ Fill billTicketSeparatelyFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billTicketsAfterClosedFlag
{{ Fill billTicketsAfterClosedFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billTime
{{ Fill billTime Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Billable, DoNotBill, NoCharge, NoDefault

Required: False
Position: 24
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billUnapprovedTimeExpenseFlag
{{ Fill billUnapprovedTimeExpenseFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -boardIcon
{{ Fill boardIcon Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -closedLoopAllFlag
{{ Fill closedLoopAllFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 55
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -closedLoopDiscussionsFlag
{{ Fill closedLoopDiscussionsFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 35
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -closedLoopInternalAnalysisFlag
{{ Fill closedLoopInternalAnalysisFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 37
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -closedLoopResolutionFlag
{{ Fill closedLoopResolutionFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 36
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -contactTemplate
{{ Fill contactTemplate Description }}

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

### -department
{{ Fill department Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -discussionsLockedFlag
{{ Fill discussionsLockedFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 31
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -dispatchMember
{{ Fill dispatchMember Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -dutyManagerMember
{{ Fill dutyManagerMember Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailConnectorAllowReopenClosedFlag
{{ Fill emailConnectorAllowReopenClosedFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 44
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailConnectorNeverReopenByDaysClosedFlag
{{ Fill emailConnectorNeverReopenByDaysClosedFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 50
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailConnectorNeverReopenByDaysFlag
{{ Fill emailConnectorNeverReopenByDaysFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 48
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailConnectorNewTicketNoMatchFlag
{{ Fill emailConnectorNewTicketNoMatchFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 47
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailConnectorReopenDaysClosedLimit
{{ Fill emailConnectorReopenDaysClosedLimit Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 51
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailConnectorReopenDaysLimit
{{ Fill emailConnectorReopenDaysLimit Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 49
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailConnectorReopenResourcesFlag
{{ Fill emailConnectorReopenResourcesFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 46
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailConnectorReopenStatus
{{ Fill emailConnectorReopenStatus Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 45
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
{{ Fill id Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -inactiveFlag
{{ Fill inactiveFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -internalAnalysisSort
{{ Fill internalAnalysisSort Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Ascending, Descending

Required: False
Position: 43
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -location
{{ Fill location Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -markFirstNoteIssueFlag
{{ Fill markFirstNoteIssueFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 58
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -name
{{ Fill name Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -notifyEmailFrom
{{ Fill notifyEmailFrom Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 33
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -notifyEmailFromName
{{ Fill notifyEmailFromName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 34
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -oncallMember
{{ Fill oncallMember Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -overrideBillingSetupFlag
{{ Fill overrideBillingSetupFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -percentageCalculation
{{ Fill percentageCalculation Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: ActualHours, Manual, ClosedPhases, ClosedTickets

Required: False
Position: 56
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -problemSort
{{ Fill problemSort Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Ascending, Descending

Required: False
Position: 41
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -projectFlag
{{ Fill projectFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -resolutionSort
{{ Fill resolutionSort Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Ascending, Descending

Required: False
Position: 42
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -resourceTemplate
{{ Fill resourceTemplate Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sendToCCFlag
{{ Fill sendToCCFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 53
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sendToContactFlag
{{ Fill sendToContactFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sendToResourceFlag
{{ Fill sendToResourceFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serviceManagerMember
{{ Fill serviceManagerMember Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -showDependenciesFlag
{{ Fill showDependenciesFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -showEstimatesFlag
{{ Fill showEstimatesFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -signOffTemplate
{{ Fill signOffTemplate Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeEntryDiscussionFlag
{{ Fill timeEntryDiscussionFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 38
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeEntryInternalAnalysisFlag
{{ Fill timeEntryInternalAnalysisFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 40
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeEntryLockedFlag
{{ Fill timeEntryLockedFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 32
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeEntryResolutionFlag
{{ Fill timeEntryResolutionFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 39
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -useMemberDisplayNameFlag
{{ Fill useMemberDisplayNameFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 52
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -workRole
{{ Fill workRole Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -workType
{{ Fill workType Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES
Author: Chris Taylor Date: 8/22/2018

## RELATED LINKS

[https://developer.connectwise.com/Products/Manage/REST?a=Company&e=CompanyCompanyTypeAssociations&o=UPDATE#/Boards/postServiceBoards](https://developer.connectwise.com/Products/Manage/REST?a=Company&e=CompanyCompanyTypeAssociations&o=UPDATE#/Boards/postServiceBoards)