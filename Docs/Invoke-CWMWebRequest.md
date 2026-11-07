---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# Invoke-CWMWebRequest

## SYNOPSIS
Low-level HTTP request handler for all ConnectWise Manage API calls.

## SYNTAX

```
Invoke-CWMWebRequest [[-Arguments] <Object>] [[-MaxRetry] <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Core function that handles all HTTP requests to the ConnectWise Manage API.
Manages authentication headers, connection state, error handling, and automatic
retry of transient failures that are safe to repeat.

This is the foundation function used by all other Invoke-CWM*Master functions.
It should rarely be called directly - use the higher-level master functions instead.
Behaves the same on Windows PowerShell 5.1 and PowerShell 7.

Key Features:
- Validates connection state ($CWMServerConnection)
- Adds authentication headers automatically
- Handles URI formatting corrections
- Retries 429 (any method) and 502/503/504 (GET/HEAD and read-only searches) with Retry-After or exponential backoff
- Provides detailed error messages with troubleshooting hints
- Records the server's api-current-version response header

## EXAMPLES

### EXAMPLE 1
```
$RequestArguments = @{
    Uri = 'https://na.myconnectwise.net/v4_6_release/apis/3.0/service/tickets/12345'
    Method = 'GET'
}
Invoke-CWMWebRequest -Arguments $RequestArguments
```

Makes a GET request to retrieve a ticket.

## PARAMETERS

### -Arguments
Hashtable of arguments to pass to Invoke-WebRequest.
Should include: Uri, Method, and optionally Body, Headers, ContentType
The API version is not set per request: the Accept header from Connect-CWM (the server's current
version) is used for every call.
The hashtable is copied, so the caller's hashtable (and its Headers) is not modified.
ReadOnly = $true marks a POST that only reads (a /search endpoint), so it is retried like a GET.
The key is
not sent to Invoke-WebRequest.
A WebSession in the hashtable is used instead of the connection's session.

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

### -MaxRetry
Maximum number of retry attempts.
Default: 5
Only 429 Too Many Requests (any method) and 502/503/504 on GET/HEAD (or a request with ReadOnly = $true)
are retried.
Writes that fail with
a 5xx are never retried, because the change may already have been applied and repeating it could create
a duplicate.
The wait is the server's Retry-After when present, otherwise 2, 4, 8, 16, 32 seconds
(capped at 60 seconds).

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 5
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
- Called by all Invoke-CWM*Master functions
- Handles authentication automatically
- Manages retry logic with exponential backoff
- Provides detailed error messages

Insecure redirection (PowerShell 7.4+):
- When connected with Connect-CWM -AllowInsecureRedirect, non-GET requests are sent with
  -AllowInsecureRedirect -MaximumRedirection 0 (redirects are never followed), and GET requests
  with -MaximumRedirection 50 (the default, re-applied because the setting persists on a shared session).
- A caller-supplied non-zero MaximumRedirection disables the workaround for that call.

Error Handling:
- Validates connection state before requests
- Parses API error responses
- Provides context-specific troubleshooting hints
- Retries only transient failures that are safe to repeat (see MaxRetry)
- The parsed error body is kept in $script:ErrBody and the raw ErrorDetails in $script:ErrDetails

## RELATED LINKS

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

[Connect-CWM]()

[Invoke-CWMGetMaster]()

