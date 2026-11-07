<#
.SYNOPSIS
    Generic DELETE request handler for removing ConnectWise Manage records.

.DESCRIPTION
    Master function for all delete (DELETE) operations in the module.
    Permanently removes records from the ConnectWise Manage system.

    Used by all Remove-CWM* functions (Remove-CWMTicket, Remove-CWMCompany, etc.).
    Supports -WhatIf and -Confirm for safety.

    This function calls the ConnectWise Manage API endpoint: DELETE {Endpoint}

.PARAMETER Endpoint
    The API endpoint path including the ID to delete.
    Format: '/service/tickets/12345', '/company/companies/250'

.EXAMPLE
    Invoke-CWMRemoveMaster -Endpoint '/service/tickets/12345'

    Deletes ticket with ID 12345.

.NOTES
    Author: Chris Taylor
    Date: 2024-01-01

    Internal Function:
    - Called by all Remove-CWM* functions
    - Supports -WhatIf and -Confirm for safety
    - Returns 204 (No Content) on success
    - Deletion is permanent and cannot be undone

.LINK
    Invoke-CWMWebRequest

.LINK
    Remove-CWMTicket

.LINK
    Remove-CWMCompany

#>
function Invoke-CWMRemoveMaster {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [string]$Endpoint
    )

    $URI = New-CWMUrl -Endpoint $Endpoint
    $WebRequestArguments = @{
        Uri = $URI
        Method = 'Delete'
    }
    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, "Invoke-CWMRemoveMaster")) {
        $Result =  Invoke-CWMWebRequest -Arguments $WebRequestArguments
        if($Result.content){ $Result = $Result.content | ConvertFrom-Json }
    }
    if ($Result.StatusCode -eq 204) { Write-Verbose 'Success' }
    $Result
}
