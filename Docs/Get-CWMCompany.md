---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest#/Companies
schema: 2.0.0
---

# Get-CWMCompany

## SYNOPSIS
Retrieves company records from ConnectWise Manage.

## SYNTAX

```
Get-CWMCompany [[-id] <Int32>] [-count] [[-condition] <String>] [[-orderBy] <String>]
 [[-childConditions] <String>] [[-customFieldConditions] <String>] [[-page] <Int32>] [[-pageSize] <Int32>]
 [[-fields] <String[]>] [-all] [<CommonParameters>]
```

## DESCRIPTION
Gets company information from ConnectWise Manage using either direct ID lookup
or advanced filtering.
Supports pagination, field selection, and custom field queries.

Companies are the primary customer/vendor records in ConnectWise Manage and are
used throughout the system for tickets, contacts, agreements, projects, and more.

This function calls the ConnectWise Manage API endpoint: /company/companies

## EXAMPLES

### EXAMPLE 1
```
Get-CWMCompany -id 250
```

Retrieves company with ID 250.

### EXAMPLE 2
```
Get-CWMCompany -condition "name='Acme Corp'"
```

Finds companies with the name 'Acme Corp'.

### EXAMPLE 3
```
Get-CWMCompany -condition "city='Seattle' and state='WA'" -all
```

Gets all companies in Seattle, WA.

### EXAMPLE 4
```
Get-CWMCompany -childConditions 'types/id=1' -orderBy 'name asc' -all
```

Retrieves all companies of company type 1 (for example Customer) sorted by name.
A company's types is a list, so it is filtered with -childConditions, not -condition.

### EXAMPLE 5
```
Get-CWMCompany -condition "status/name='Active'" -fields @('id', 'name', 'phoneNumber') -all
```

Gets active companies with only specific fields.

## PARAMETERS

### -id
The unique identifier for a specific company.
When specified, returns only the company with this ID.
Alias: companyId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: companyId

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -count
Returns only the count of matching companies instead of company data.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -condition
Filter companies using ConnectWise Manage condition syntax.
Examples:
- "name='Acme Corp'"
- "city='New York' and state='NY'"
- "status/name='Active'"

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -orderBy
Sort results by specified field.
Examples: "id desc", "name asc"

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -childConditions
Filter based on child record criteria.

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

### -customFieldConditions
Filter based on custom field values.

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

### -page
Page number for pagination (default: 1).

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -pageSize
Records per page.
The module does not enforce a maximum; the API applies its own limit.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -fields
Specify which fields to return.
Example: @('id', 'name', 'identifier', 'status')

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -all
Retrieve all matching companies automatically handling pagination.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Chris Taylor

Common Filters:
- By type (a list field, so use -childConditions): 'types/id=1'
- By status: "status/name='Active'"
- By location: "city='CityName' and state='ST'"
- By territory: "territory/id=5"

## RELATED LINKS

[https://developer.connectwise.com/manage/rest#/Companies](https://developer.connectwise.com/manage/rest#/Companies)

[New-CWMCompany]()

[Update-CWMCompany]()

[Remove-CWMCompany]()

