---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Invoke-CWMSearchMaster

## SYNOPSIS
Generic POST-based search handler for complex queries.

## SYNTAX

```
Invoke-CWMSearchMaster [[-Arguments] <Object>] [[-Endpoint] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Master function for POST-based search operations.
Used when GET endpoints don't support
complex queries or when the query string would be too long for a GET request.

The filter parameters go in the JSON request body, allowing for more complex filtering
than standard GET requests.
Field selection and paging go in the query string.

This function calls the ConnectWise Manage API endpoint: POST {Endpoint}
It does not append /search; the endpoint you pass must already include it
(for example '/service/tickets/search').
Passing a collection endpoint such as
'/service/tickets' would POST to the create endpoint instead.

## EXAMPLES

### EXAMPLE 1
```
$SearchArguments = @{
    condition = "company/id=250 and status/name='Open'"
    orderBy = "id desc"
    all = $true
}
Invoke-CWMSearchMaster -Arguments $SearchArguments -Endpoint '/service/tickets/search'
```

Searches for all open tickets for company 250.

## PARAMETERS

### -Arguments
Hashtable containing search parameters:
- condition: Filter string (POST body, as 'conditions')
- orderBy: Sort specification (POST body)
- childConditions: Filter on child records (POST body)
- customFieldConditions: Filter on custom fields (POST body)
- fields: Field selection (query string)
- page, pageSize: Pagination (query string)
- all: Switch to retrieve all pages

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
The full search endpoint path, including /search (e.g., '/service/tickets/search')

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
- Called by Get-CWMTicket for list queries (POST /service/tickets/search)
- Uses POST method with JSON body
- Supports UTF-8 encoding for international characters
- Routes to Invoke-CWMAllResult for -all requests
- Retried on 502/503/504 like a GET (ReadOnly = $true), because a search changes nothing

## RELATED LINKS

[Invoke-CWMWebRequest]()

[Invoke-CWMGetMaster]()

[Invoke-CWMAllResult]()

