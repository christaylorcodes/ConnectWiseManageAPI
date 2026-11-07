<#
.SYNOPSIS
    Generic POST request handler for ConnectWise Manage action endpoints that take no request body.

.DESCRIPTION
    Master function for action endpoints, such as
    /company/companies/{parentId}/serviceTemplates/{id}/link, that are triggered by a POST with no body.
    Unlike Invoke-CWMNewMaster, no body and no content type are sent.

    Used by action functions such as Add-CWMCompanyServiceTemplateLink and Copy-CWMCompanyServiceTemplate.

    This function calls the ConnectWise Manage API endpoint: POST {Endpoint}

.PARAMETER Endpoint
    The API endpoint path of the action, e.g. '/company/companies/250/serviceTemplates/15/link'.

.EXAMPLE
    Invoke-CWMActionMaster -Endpoint '/company/companies/250/serviceTemplates/15/link'

    Links company service template 15 of company 250.

.EXAMPLE
    Invoke-CWMActionMaster -Endpoint '/company/companies/250/serviceTemplates/15/copy' -WhatIf

    Shows the request that would be sent, without sending it.

.NOTES
    Author: Chris Taylor

    Internal Function:
    - Called by action functions (Add-/Remove-CWMCompanyServiceTemplateLink, Copy-CWMCompanyServiceTemplate)
    - Supports -WhatIf and -Confirm
    - The response, when there is one, is converted with ConvertFrom-CWMJson

    Based on PR #82 by mdewart-Centre.

.LINK
    Invoke-CWMWebRequest

.LINK
    Invoke-CWMNewMaster

.LINK
    Add-CWMCompanyServiceTemplateLink

#>
function Invoke-CWMActionMaster {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [string]$Endpoint
    )

    $Result = $null
    $URI = New-CWMUrl -Endpoint $Endpoint
    $WebRequestArguments = @{
        Uri    = $URI
        Method = 'Post'
    }

    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, 'Invoke-CWMActionMaster')) {
        $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments
        if ($Result.content) {
            $Result = ConvertFrom-CWMJson $Result.Content
        }
    }

    $Result
}
