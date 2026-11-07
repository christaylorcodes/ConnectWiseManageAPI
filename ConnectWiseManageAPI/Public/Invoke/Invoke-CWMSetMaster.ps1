<#
.SYNOPSIS
    Generic PUT request handler for replacing ConnectWise Manage records.

.DESCRIPTION
    Master function for replace (PUT) operations. The whole record is replaced with the properties
    passed in $Arguments, so properties that are not included may be cleared by the API. To change
    only some fields, use Invoke-CWMUpdateMaster (PATCH) instead.

    Used by Set-CWM* functions such as Set-CWMCompanyServiceTemplate.
    PowerShell common parameters, the parameters in $Skip, and the route ids (id, parentId,
    grandparentId) are left out of the body.

    This function calls the ConnectWise Manage API endpoint: PUT {Endpoint}

.PARAMETER Arguments
    Hashtable (usually $PSBoundParameters) containing the properties of the record.
    If it contains Body, that value is sent as is and the other properties are ignored.

.PARAMETER Endpoint
    The API endpoint path including the record id, e.g. '/company/companies/250/serviceTemplates/15'.

.PARAMETER Skip
    Array of parameter names to exclude from the request body.
    Common parameters and route ids are always skipped.

.EXAMPLE
    $SetArguments = @{
        name    = 'Monthly maintenance'
        summary = 'Monthly maintenance'
        board   = @{ id = 1 }
        status  = @{ id = 16 }
    }
    Invoke-CWMSetMaster -Arguments $SetArguments -Endpoint '/company/companies/250/serviceTemplates/15'

    Replaces company service template 15 of company 250.

.NOTES
    Author: Chris Taylor

    Internal Function:
    - Called by Set-CWM* functions
    - Supports -WhatIf and -Confirm
    - Sends 'application/json; charset=utf-8', like Invoke-CWMNewMaster and Invoke-CWMUpdateMaster
    - The response is converted with ConvertFrom-CWMJson

    Based on PR #82 by mdewart-Centre.

.LINK
    Invoke-CWMWebRequest

.LINK
    Invoke-CWMUpdateMaster

.LINK
    Set-CWMCompanyServiceTemplate

#>
function Invoke-CWMSetMaster {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        $Arguments,
        [string]$Endpoint,
        [string[]]$Skip
    )

    # The record id is part of the route, not the body
    $Body = ConvertTo-CWMRequestBody -Arguments $Arguments -Skip ($Skip + 'id')
    $BodyText = [string]$Body
    Write-Verbose $BodyText

    $URI = New-CWMUrl -Endpoint $Endpoint

    $WebRequestArguments = @{
        Uri         = $URI
        Method      = 'Put'
        ContentType = 'application/json; charset=utf-8'
        Body        = $Body
        Version     = $Arguments.Version
    }

    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, "Invoke-CWMSetMaster, with body:`r`n$BodyText`r`n")) {
        $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments

        if ($Result.content) {
            $Result = ConvertFrom-CWMJson $Result.Content
        }
    }

    $Result
}
