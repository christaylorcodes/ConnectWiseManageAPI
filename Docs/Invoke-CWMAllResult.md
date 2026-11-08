---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Invoke-CWMAllResult

## SYNOPSIS
Automatic pagination handler that retrieves all pages of results.

## SYNTAX

```
Invoke-CWMAllResult [[-Arguments] <Object>] [[-PageSize] <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Handles automatic pagination for API requests using forward-only pagination.
Called by Invoke-CWMGetMaster and Invoke-CWMSearchMaster when -all switch is used.

Automatically follows pagination links in response headers to retrieve all pages
of results.
Uses page size 1000 (the API maximum, or -PageSize) and forward-only pagination
for better performance.

This function iterates through all pages until no more results are available.

## EXAMPLES

### EXAMPLE 1
```
$Condition = [System.Web.HttpUtility]::UrlEncode("status/name='Open'")
$RequestArguments = @{
    Uri = "https://na.myconnectwise.net/v4_6_release/apis/3.0/service/tickets?conditions=$Condition"
    Method = 'GET'
}
Invoke-CWMAllResult -Arguments $RequestArguments
```

Retrieves all pages of open tickets.

## PARAMETERS

### -Arguments
Hashtable containing web request parameters:
- Uri: Initial request URI
- Method: HTTP method (GET or POST)
- Body: Request body (for POST requests)
- Headers: Request headers

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

### -PageSize
Records per request.
Defaults to 1000, the API's maximum; values below 1 or above 1000 use 1000.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 1000
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
- Called by Invoke-CWMGetMaster and Invoke-CWMSearchMaster
- Uses forward-only pagination for performance
- Uses page size 1000 (the API maximum) unless -PageSize is smaller
- Follows Link headers for next page, but only to the connected server: the next-page URL must use
  https (or the scheme of the first request, never a downgrade) and the connection's host and port.
Any other
  URL stops paging with a terminating error, so credentials are never sent to another host and the
  caller never gets a silently partial result.
- Returns results from all pages

Performance:
- More efficient than manual pagination
- Reduces number of API calls
- Recommended for retrieving large datasets

## RELATED LINKS

[Invoke-CWMWebRequest]()

[Invoke-CWMGetMaster]()

[Invoke-CWMSearchMaster]()

