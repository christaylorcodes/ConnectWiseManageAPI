---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Invoke-CWMUpdateMaster

## SYNOPSIS
Generic PATCH request handler for updating ConnectWise Manage records.

## SYNTAX

```
Invoke-CWMUpdateMaster [[-Arguments] <Object>] [[-Endpoint] <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Master function for all update (PATCH) operations in the module.
Implements RFC 6902 JSON Patch standard for updating records.

Used by all Update-CWM* functions (Update-CWMTicket, Update-CWMCompany, etc.).
Constructs patch operation array and submits to the API.

Two modes:
- Bulk: when $Arguments contains PatchOperations, those operations are the whole request body and
  Operation/Path/Value are ignored.
Several fields can be changed in one request.
- Single: otherwise one operation is built from Operation, Path and Value.
Value is optional for
  'remove'.
For 'add' and 'replace' a Value key is required (it may be $null), so a forgotten
  -Value is an error instead of silently sending null.

In both modes:
- 'value' is left out of 'remove' operations.
- A value wrapped in a PSObject (for example an array returned from a function) is unwrapped, so
  Windows PowerShell 5.1 does not serialize it as {"value":\[...\],"Count":n}.
A PSCustomObject (for
  example $Ticket.board from Get-CWMTicket), or an array of them, is sent with all its properties.
- Verbose and -WhatIf output masks secrets: values of keys such as password or token, and the value
  of an operation whose path is such a key.
- The body is always a JSON array, even with a single operation.

This function calls the ConnectWise Manage API endpoint: PATCH {Endpoint}

## EXAMPLES

### EXAMPLE 1
```
$UpdateArguments = @{
    Operation = 'replace'
    Path = 'status'
    Value = @{ id = 10 }
}
Invoke-CWMUpdateMaster -Arguments $UpdateArguments -Endpoint '/service/tickets/12345'
```

Updates ticket status.

### EXAMPLE 2
```
$UpdateArguments = @{
    PatchOperations = @(
        @{ op = 'replace'; path = 'summary'; value = 'New summary' }
        @{ op = 'replace'; path = 'status'; value = @{ id = 10 } }
        @{ op = 'remove'; path = 'contact' }
    )
}
Invoke-CWMUpdateMaster -Arguments $UpdateArguments -Endpoint '/service/tickets/12345'
```

Changes the summary and status and clears the contact of ticket 12345 in one request.

## PARAMETERS

### -Arguments
Hashtable (usually $PSBoundParameters) containing either:
- PatchOperations: Array of operations, each a hashtable or PSCustomObject with op, path and
  (except for 'remove') value.
A 'from' member is passed through for 'move' and 'copy'.
or:
- Operation: 'add', 'replace', or 'remove'
- Path: Field path to modify
- Value: New value (not needed for 'remove'; required, but may be $null, for 'add' and 'replace')

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
The API endpoint path (e.g., '/service/tickets/123', '/company/companies/250')

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

Internal Function:
- Called by all Update-CWM* functions
- Supports -WhatIf and -Confirm
- Implements JSON Patch (RFC 6902)
- Converts parameters to patch operation array

PatchOperations (issue #53) is based on PR #82 by mdewart-Centre.

## RELATED LINKS

[Invoke-CWMWebRequest]()

[Update-CWMTicket]()

[Update-CWMCompany]()

[https://github.com/christaylorcodes/ConnectWiseManageAPI/issues/53](https://github.com/christaylorcodes/ConnectWiseManageAPI/issues/53)

