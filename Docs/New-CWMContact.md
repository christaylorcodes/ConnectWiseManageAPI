---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMContact

## SYNOPSIS
This function will create a new contact.

## SYNTAX

```
New-CWMContact [[-id] <Int32>] [-firstName] <String> [[-lastName] <String>] [[-type] <Hashtable>]
 [[-company] <Hashtable>] [[-site] <Hashtable>] [[-addressLine1] <String>] [[-addressLine2] <String>]
 [[-city] <String>] [[-state] <String>] [[-zip] <String>] [[-country] <String>] [[-relationship] <Hashtable>]
 [[-department] <Hashtable>] [[-inactiveFlag] <Boolean>] [[-defaultMergeContactId] <Int32>]
 [[-securityIdentifier] <String>] [[-managerContactId] <Int32>] [[-assistantContactId] <Int32>]
 [[-title] <String>] [[-school] <String>] [[-nickName] <String>] [[-marriedFlag] <Boolean>]
 [[-childrenFlag] <Boolean>] [[-significantOther] <String>] [[-portalPassword] <SecureString>]
 [[-portalSecurityLevel] <Int32>] [[-disablePortalLoginFlag] <Boolean>] [[-unsubscribeFlag] <Boolean>]
 [[-gender] <String>] [[-birthDay] <String>] [[-anniversary] <String>] [[-presence] <String>]
 [[-mobileGuid] <Guid>] [[-facebookUrl] <String>] [[-twitterUrl] <String>] [[-linkedInUrl] <String>]
 [[-defaultBillingFlag] <Boolean>] [[-defaultFlag] <Boolean>] [[-communicationItems] <Hashtable[]>]
 [[-_info] <Hashtable>] [[-customFields] <Hashtable[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
New-CWMContact -firstName 'Chris' -lastName 'Taylor' -company @{id = $Company.id}
```

Create a new contact.

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
{{ Fill _info Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 40
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -addressLine1
{{ Fill addressLine1 Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -addressLine2
{{ Fill addressLine2 Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -anniversary
{{ Fill anniversary Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 31
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -assistantContactId
{{ Fill assistantContactId Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -birthDay
{{ Fill birthDay Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -childrenFlag
{{ Fill childrenFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -city
{{ Fill city Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -communicationItems
{{ Fill communicationItems Description }}

```yaml
Type: Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 39
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -company
{{ Fill company Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -country
{{ Fill country Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customFields
{{ Fill customFields Description }}

```yaml
Type: Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 41
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -defaultBillingFlag
{{ Fill defaultBillingFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 37
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -defaultFlag
{{ Fill defaultFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 38
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -defaultMergeContactId
{{ Fill defaultMergeContactId Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: 0
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
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -disablePortalLoginFlag
{{ Fill disablePortalLoginFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -facebookUrl
{{ Fill facebookUrl Description }}

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

### -firstName
{{ Fill firstName Description }}

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

### -gender
{{ Fill gender Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Male, Female

Required: False
Position: 29
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
Default value: 0
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
Position: 14
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -lastName
{{ Fill lastName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -linkedInUrl
{{ Fill linkedInUrl Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 36
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -managerContactId
{{ Fill managerContactId Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -marriedFlag
{{ Fill marriedFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -mobileGuid
{{ Fill mobileGuid Description }}

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: 33
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -nickName
{{ Fill nickName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -portalPassword
{{ Fill portalPassword Description }}

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -portalSecurityLevel
{{ Fill portalSecurityLevel Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -presence
{{ Fill presence Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Online, DoNotDisturb, Away, Offline, NoAgent

Required: False
Position: 32
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -relationship
{{ Fill relationship Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -school
{{ Fill school Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -securityIdentifier
{{ Fill securityIdentifier Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -significantOther
{{ Fill significantOther Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -site
{{ Fill site Description }}

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

### -state
{{ Fill state Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -title
{{ Fill title Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -twitterUrl
{{ Fill twitterUrl Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 35
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
{{ Fill type Description }}

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

### -unsubscribeFlag
{{ Fill unsubscribeFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 28
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -zip
{{ Fill zip Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Chris Taylor Date: 10/10/2018

## RELATED LINKS

[https://marketplace.connectwise.com/docs/redoc/manage/company.html#tag/Contacts/paths/~1company~1contacts/post](https://marketplace.connectwise.com/docs/redoc/manage/company.html#tag/Contacts/paths/~1company~1contacts/post)

