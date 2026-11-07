---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest#/Companies
schema: 2.0.0
---

# Remove-CWMCompany

## SYNOPSIS
Deletes a company from ConnectWise Manage.

## SYNTAX

```
Remove-CWMCompany [-id] <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Permanently removes a company record by ID.
This action cannot be undone.

ConnectWise Manage decides what happens to related records (contacts, tickets,
agreements, projects) and may refuse the delete.
Consider marking the company as
inactive instead of deleting it to preserve history.

ConfirmImpact is Medium, so with the default $ConfirmPreference (High) there is no
confirmation prompt: the company is deleted immediately.
Use -Confirm to be prompted
or -WhatIf to preview.

This function calls the ConnectWise Manage API endpoint: DELETE /company/companies/{id}

## EXAMPLES

### EXAMPLE 1
```
Remove-CWMCompany -id 250
```

Deletes company with ID 250.

### EXAMPLE 2
```
Remove-CWMCompany -id 250 -Confirm
```

Prompts for confirmation before deleting the company.

### EXAMPLE 3
```
Remove-CWMCompany -id 250 -WhatIf
```

Shows what would happen without actually deleting.

## PARAMETERS

### -id
The company ID to delete (required).
Alias: companyId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: companyId

Required: True
Position: 1
Default value: 0
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

Important:
- This action is permanent and cannot be undone
- ConnectWise Manage may reject the delete when related records exist
- Consider using an inactive status instead of deletion
- Supports -WhatIf and -Confirm (no prompt by default)

Alternative to Deletion:
Mark the company inactive instead.
Status IDs differ per instance, so look the ID up first:
$Inactive = Get-CWMCompanyStatus -condition "inactiveFlag=true" | Select-Object -First 1
Update-CWMCompany -id 250 -Operation 'replace' -Path 'status' -Value @{ id = $Inactive.id }

## RELATED LINKS

[https://developer.connectwise.com/manage/rest#/Companies](https://developer.connectwise.com/manage/rest#/Companies)

[Get-CWMCompany]()

[New-CWMCompany]()

[Update-CWMCompany]()

