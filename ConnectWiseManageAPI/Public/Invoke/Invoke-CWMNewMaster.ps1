<#
.SYNOPSIS
    Generic POST request handler for creating new ConnectWise Manage records.

.DESCRIPTION
    Master function for all create (POST) operations in the module.
    Converts function parameters to JSON body and submits to the API.

    Used by all New-CWM* functions (New-CWMTicket, New-CWMCompany, etc.).
    Automatically filters out PowerShell common parameters and skipped parameters.

    This function calls the ConnectWise Manage API endpoint: POST {Endpoint}

.PARAMETER Arguments
    Hashtable containing the properties for the new record.
    Common parameters and those in $Skip are automatically filtered out.

.PARAMETER Endpoint
    The API endpoint path (e.g., '/service/tickets', '/company/companies')

.PARAMETER Skip
    Array of parameter names to exclude from the request body.
    Common parameters are automatically skipped.

.EXAMPLE
    $args = @{
        summary = "New ticket"
        company = @{ id = 250 }
        board = @{ id = 1 }
    }
    Invoke-CWMNewMaster -Arguments $args -Endpoint '/service/tickets'

    Creates a new ticket.

.NOTES
    Author: Chris Taylor
    Date: 2024-01-01

    Internal Function:
    - Called by all New-CWM* functions
    - Supports -WhatIf and -Confirm
    - Automatically filters PowerShell common parameters
    - Converts parameters to JSON body

.LINK
    Invoke-CWMWebRequest

.LINK
    New-CWMTicket

.LINK
    New-CWMCompany

#>
function Invoke-CWMNewMaster {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        $Arguments,
        [string]$Endpoint,
        [string[]]$Skip
    )
    # Skip common parameters
    $Skip += 'Debug', 'ErrorAction', 'ErrorVariable', 'InformationAction', 'InformationVariable', 'OutVariable', 'OutBuffer', 'PipelineVariable', 'Verbose', 'WarningAction', 'WarningVariable', 'WhatIf', 'Confirm', 'Version', 'VersionAutomatic', 'grandparentId', 'parentId'

    if ($Arguments.Body) {
        $Body = $Arguments.Body
    }
    else {
        $Body = @{}

        foreach ($i in $Arguments.GetEnumerator()) {
            if ($Skip -notcontains $i.Key) {
                $Body.Add($i.Key, $i.value)
            }
        }

        $Body = ConvertTo-Json $Body -Depth 100
    }
    Write-Verbose $Body

    $ContentType = 'application/json'
    if ($Arguments.ContentType) {
        $ContentType = $Arguments.ContentType
    }

    $URI = New-CWMUrl -Endpoint $Endpoint

    $WebRequestArguments = @{
        Uri         = $URI
        Method      = 'Post'
        ContentType = $ContentType
        Body        = $Body
        Version     = $Arguments.Version
        Headers     = $Arguments.Headers
    }

    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, "Invoke-CWMNewMaster, with body:`r`n$Body`r`n")) {
        $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments

        if ($Result.content) {
            $Result = $Result.content | ConvertFrom-Json
        }
    }

    $Result
}
