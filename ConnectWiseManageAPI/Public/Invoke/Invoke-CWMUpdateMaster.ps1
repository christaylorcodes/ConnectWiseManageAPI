<#
.SYNOPSIS
    Generic PATCH request handler for updating ConnectWise Manage records.

.DESCRIPTION
    Master function for all update (PATCH) operations in the module.
    Implements RFC 6902 JSON Patch standard for updating records.

    Used by all Update-CWM* functions (Update-CWMTicket, Update-CWMCompany, etc.).
    Constructs patch operation array and submits to the API.

    Two modes:
    - Bulk: when $Arguments contains PatchOperations, those operations are the whole request body and
      Operation/Path/Value are ignored. Several fields can be changed in one request.
    - Single: otherwise one operation is built from Operation, Path and Value.

    In both modes:
    - 'value' is left out of 'remove' operations.
    - A value wrapped in a PSObject (for example an array returned from a function) is unwrapped, so
      Windows PowerShell 5.1 does not serialize it as {"value":[...],"Count":n}.
    - The body is always a JSON array, even with a single operation.

    This function calls the ConnectWise Manage API endpoint: PATCH {Endpoint}

.PARAMETER Arguments
    Hashtable (usually $PSBoundParameters) containing either:
    - PatchOperations: Array of operations, each a hashtable or PSCustomObject with op, path and
      (except for 'remove') value. A 'from' member is passed through for 'move' and 'copy'.
    or:
    - Operation: 'add', 'replace', or 'remove'
    - Path: Field path to modify
    - Value: New value (not needed for 'remove')

.PARAMETER Endpoint
    The API endpoint path (e.g., '/service/tickets/123', '/company/companies/250')

.EXAMPLE
    $UpdateArguments = @{
        Operation = 'replace'
        Path = 'status'
        Value = @{ id = 10 }
    }
    Invoke-CWMUpdateMaster -Arguments $UpdateArguments -Endpoint '/service/tickets/12345'

    Updates ticket status.

.EXAMPLE
    $UpdateArguments = @{
        PatchOperations = @(
            @{ op = 'replace'; path = 'summary'; value = 'New summary' }
            @{ op = 'replace'; path = 'status'; value = @{ id = 10 } }
            @{ op = 'remove'; path = 'contact' }
        )
    }
    Invoke-CWMUpdateMaster -Arguments $UpdateArguments -Endpoint '/service/tickets/12345'

    Changes the summary and status and clears the contact of ticket 12345 in one request.

.NOTES
    Author: Chris Taylor
    Date: 2024-01-01

    Internal Function:
    - Called by all Update-CWM* functions
    - Supports -WhatIf and -Confirm
    - Implements JSON Patch (RFC 6902)
    - Converts parameters to patch operation array

    PatchOperations (issue #53) is based on PR #82 by mdewart-Centre.

.LINK
    Invoke-CWMWebRequest

.LINK
    Update-CWMTicket

.LINK
    Update-CWMCompany

.LINK
    https://github.com/christaylorcodes/ConnectWiseManageAPI/issues/53

#>
function Invoke-CWMUpdateMaster {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        $Arguments,
        [string]$Endpoint
    )


    $Operations = New-Object System.Collections.Generic.List[object]

    if ($Arguments.Keys -contains 'PatchOperations') {
        $PatchOperations = @($Arguments.PatchOperations | Where-Object { $null -ne $_ })
        if ($PatchOperations.Count -lt 1) {
            return Write-Error 'PatchOperations is empty. Provide at least one operation, e.g. @{ op = ''replace''; path = ''summary''; value = ''New'' }.'
        }

        foreach ($PatchOperation in $PatchOperations) {
            # Hashtables and PSCustomObjects are both accepted
            $Members = @{}
            if ($PatchOperation -is [System.Collections.IDictionary]) {
                foreach ($Key in $PatchOperation.Keys) { $Members[[string]$Key] = $PatchOperation[$Key] }
            }
            else {
                foreach ($Property in $PatchOperation.psobject.Properties) { $Members[$Property.Name] = $Property.Value }
            }

            if (!$Members.op -or !$Members.path) {
                return Write-Error "Each patch operation needs 'op' and 'path'. Invalid operation: $($PatchOperation | Out-String)"
            }

            $Operation = [ordered]@{
                op   = ([string]$Members.op).ToLower()
                path = $Members.path
            }
            if ($Members.ContainsKey('from')) { $Operation.from = $Members.from }
            if ($Operation.op -ne 'remove') {
                # Unwrap: 5.1 serializes a PSObject-wrapped array as {"value":[..],"Count":n}
                $Value = $Members.value
                if ($null -ne $Value) { $Value = $Value.psobject.BaseObject }
                $Operation.value = $Value
            }
            $Operations.Add($Operation)
        }
    }
    else {
        Write-Verbose $($Arguments.Value | Out-String)
        $Operation = [ordered]@{
            op   = $Arguments.Operation.toLower()
            path = $Arguments.Path
        }
        if ($Operation.op -ne 'remove') {
            $Value = $Arguments.Value
            if ($null -ne $Value) { $Value = $Value.psobject.BaseObject }
            $Operation.value = $Value
        }
        $Operations.Add($Operation)
    }

    # -InputObject with an object[] always serializes as a JSON array, also with one element on 5.1
    $Body = ConvertTo-Json -InputObject $Operations.ToArray() -Depth 100
    Write-Verbose $Body

    $URI = New-CWMUrl -Endpoint $Endpoint
    $WebRequestArguments = @{
        Uri         = $URI
        Method      = 'Patch'
        ContentType = 'application/json; charset=utf-8'
        Body        = $Body
    }
    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, "Invoke-CWMUpdateMaster, with body:`r`n$Body`r`n")) {
        $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments
        if ($Result.content) {
            $Result = ConvertFrom-CWMJson $Result.Content
        }
    }

    $Result
}
