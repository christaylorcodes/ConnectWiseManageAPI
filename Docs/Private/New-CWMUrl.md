---
external help file:
Module Name:
online version:
schema: 2.0.0
---

# New-CWMUrl

## SYNOPSIS
Builds the full URL of an API request.

## SYNTAX

```
New-CWMUrl [[-Endpoint] <String>] [[-URLParameters] <String>]
```

## DESCRIPTION
Joins https://, the server, the codebase and the base path of the current connection
($script:CWMServerConnection) with the endpoint, then appends the query string.
Returns nothing when
there is no connection.
Internal helper; no API call is made.

## EXAMPLES

### EXAMPLE 1
```
New-CWMUrl -Endpoint '/service/tickets' -URLParameters '&pageSize=10'
```

Returns the full URL of the tickets endpoint for the current connection, with &pageSize=10 appended.

## PARAMETERS

### -Endpoint
The API endpoint path, for example '/service/tickets'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -URLParameters
The query string to append as is, for example '&conditions=id%3D1'.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
