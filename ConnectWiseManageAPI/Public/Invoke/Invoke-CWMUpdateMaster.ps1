<#
.SYNOPSIS
    Generic PATCH request handler for updating ConnectWise Manage records.

.DESCRIPTION
    Master function for all update (PATCH) operations in the module.
    Implements RFC 6902 JSON Patch standard for updating records.

    Used by all Update-CWM* functions (Update-CWMTicket, Update-CWMCompany, etc.).
    Constructs patch operation array and submits to the API.

    This function calls the ConnectWise Manage API endpoint: PATCH {Endpoint}

.PARAMETER Arguments
    Hashtable containing patch operation parameters:
    - Operation: 'add', 'replace', or 'remove'
    - Path: Field path to modify
    - Value: New value (not needed for 'remove')

.PARAMETER Endpoint
    The API endpoint path (e.g., '/service/tickets/123', '/company/companies/250')

.EXAMPLE
    $args = @{
        Operation = 'replace'
        Path = 'status'
        Value = @{ id = 10 }
    }
    Invoke-CWMUpdateMaster -Arguments $args -Endpoint '/service/tickets/12345'

    Updates ticket status.

.NOTES
    Author: Chris Taylor
    Date: 2024-01-01

    Internal Function:
    - Called by all Update-CWM* functions
    - Supports -WhatIf and -Confirm
    - Implements JSON Patch (RFC 6902)
    - Converts parameters to patch operation array

.LINK
    Invoke-CWMWebRequest

.LINK
    Update-CWMTicket

.LINK
    Update-CWMCompany

#>
function Invoke-CWMUpdateMaster {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        $Arguments,
        [string]$Endpoint
    )

    Write-Verbose $($Arguments.Value | Out-String)
    $Body = @(
        @{
            op    = $Arguments.Operation.toLower()
            path  = $Arguments.Path
            value = $Arguments.Value
        }
    )
    $Body = ConvertTo-Json $Body -Depth 100
    Write-Verbose $Body

    $URI = New-CWMUrl -Endpoint $Endpoint
    $WebRequestArguments = @{
        Uri         = $URI
        Method      = 'Patch'
        ContentType = 'application/json'
        Body        = $Body
    }
    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, "Invoke-CWMUpdateMaster, with body:`r`n$Body`r`n")) {
        $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments
        if ($Result.content) {
            $Result = $Result.content | ConvertFrom-Json
        }
    }

    $Result
}
