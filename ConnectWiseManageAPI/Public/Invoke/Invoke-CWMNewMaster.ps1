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
    $NewArguments = @{
        summary = "New ticket"
        company = @{ id = 250 }
        board = @{ id = 1 }
    }
    Invoke-CWMNewMaster -Arguments $NewArguments -Endpoint '/service/tickets'

    Creates a new ticket.

.NOTES
    Author: Chris Taylor

    Internal Function:
    - Called by all New-CWM* functions
    - Supports -WhatIf and -Confirm
    - Automatically filters PowerShell common parameters
    - Converts parameters to JSON body
    - Writes a warning when the response is a single record with id 0. PR #82 reported that
      POST /company/companies/{id}/serviceTemplates without a company returns a record with id 0
      and creates nothing. The warning is based on PR #82 by mdewart-Centre.

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
    # A binary body (e.g. a multipart document upload as byte[]) is summarized instead of printed
    if ($Body -is [byte[]]) { $BodyText = "[$($Body.Length) bytes]" }
    else { $BodyText = [string]$Body }
    Write-Verbose $BodyText

    $ContentType = 'application/json; charset=utf-8'
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

    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, "Invoke-CWMNewMaster, with body:`r`n$BodyText`r`n")) {
        $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments

        if ($Result.content) {
            $Result = ConvertFrom-CWMJson $Result.Content
        }

        # A record with id 0 means nothing was created (seen when a required field is missing, see PR #82)
        if ($Result -and $Result -isnot [array] -and $Result.PSObject.Properties['id'] -and $Result.id -eq 0) {
            Write-Warning "The API returned id 0 for $($WebRequestArguments.URI); nothing was likely created. Check that the request includes all required fields."
        }
    }

    $Result
}
