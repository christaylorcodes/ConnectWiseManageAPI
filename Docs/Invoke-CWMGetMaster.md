---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Invoke-CWMGetMaster

## SYNOPSIS
Generic GET request handler for retrieving ConnectWise Manage records.

## SYNTAX

```
Invoke-CWMGetMaster [[-Arguments] <Object>] [[-Endpoint] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Master function for all GET operations in the module.
Handles direct ID lookups,
counting, filtering, sorting, field selection, and pagination.

Used by the Get-CWM* functions (Get-CWMCompany, etc.) to retrieve data.
Get-CWMTicket uses it
for id and count lookups and sends list queries to Invoke-CWMSearchMaster.
Automatically routes to Invoke-CWMAllResult when -all switch is used.

This function calls the ConnectWise Manage API endpoint: GET {Endpoint}

## EXAMPLES

### EXAMPLE 1
```
$QueryArguments = @{
    condition = "status/name='Open'"
    orderBy = "id desc"
    all = $true
}
Invoke-CWMGetMaster -Arguments $QueryArguments -Endpoint '/service/tickets'
```

Retrieves all open tickets sorted by ID descending.

### EXAMPLE 2
```
Invoke-CWMGetMaster -Arguments @{ id = 12345 } -Endpoint '/service/tickets'
```

Retrieves ticket 12345 (GET /service/tickets/12345).

### EXAMPLE 3
```
Invoke-CWMGetMaster -Arguments @{ pageId = 500; pageSize = 100 } -Endpoint '/service/tickets'
```

Retrieves up to 100 tickets, starting from the page identified by pageId 500.

## PARAMETERS

### -Arguments
Hashtable containing query parameters:
- id: Direct ID lookup
- condition: Filter string
- orderBy: Sort specification
- childConditions: Filter on child records
- customFieldConditions: Filter on custom fields
- page, pageSize: Pagination
- pageId: Record id to start forward-only pagination from (sent as &pageId=)
- fields: Field selection array
- all: Switch to retrieve all pages
- count: Switch to return count only.
Must be a SwitchParameter (as in $PSBoundParameters);
  count = $true is ignored because the check uses .IsPresent

The id is read from $Arguments.id only; variables in the caller's scope are never used.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Endpoint
The API endpoint path (e.g., '/service/tickets', '/company/companies')

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Chris Taylor

Internal Function:
- Called by the Get-CWM* functions
- Handles pagination automatically with -all
- Routes to Invoke-CWMAllResult for -all requests
- Supports both direct lookups and filtered queries

pageId support and the $Arguments.id fix are based on PR #82 by mdewart-Centre.

## RELATED LINKS

[Invoke-CWMWebRequest]()

[Invoke-CWMAllResult]()

[Invoke-CWMSearchMaster]()

