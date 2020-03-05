---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMCompanyTeam

## SYNOPSIS
This function will create a new company team.

## SYNTAX

```
New-CWMCompanyTeam [-id] <Int32> [[-company] <Hashtable>] [-teamRole] <Hashtable> [[-locationId] <Int32>]
 [[-businessUnitId] <Int32>] [[-contact] <Hashtable>] [[-member] <Hashtable>] [[-accountManagerFlag] <Boolean>]
 [[-techFlag] <Boolean>] [[-salesFlag] <Boolean>] [[-_info] <Hashtable>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
New-CWMCompanyTeam -id $CompanyID -TeamRole @{id = $Role.id}
```

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
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -accountManagerFlag
{{ Fill accountManagerFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -businessUnitId
The ID of the business unit you want to associate the team with.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -company
Company object of the company you want to add the team to.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -contact
Contact object

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

### -id
The ID of the company you want to add the team to.

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

### -locationId
The ID of the location you want to associate the team with.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -member
Member object

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -salesFlag
{{ Fill salesFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -teamRole
The team role reference of the role you want to add.
Get-CWMCompanyTeamRole

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

### -techFlag
{{ Fill techFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Chris Taylor Date: 8/22/2018

## RELATED LINKS

[https://marketplace.connectwise.com/docs/redoc/manage/company.html#tag/CompanyTeams/paths/~1company~1companies~1{id}~1teams/post](https://marketplace.connectwise.com/docs/redoc/manage/company.html#tag/CompanyTeams/paths/~1company~1companies~1{id}~1teams/post)

