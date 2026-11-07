<#
.SYNOPSIS
    Adds a company to a marketing group.

.DESCRIPTION
    Adds a company to a marketing group in ConnectWise Manage. Calls POST
    /marketing/groups/{parentId}/companies; only the parameters you pass are sent in the request body.

.PARAMETER parentId
    The id of the marketing group to add the company to.
    Alias: groupId

.PARAMETER id
    The id of the company to add to the marketing group (sent as id in the request body).
    Alias: companyId

.PARAMETER defaultContactFlag
    Default contact flag. $true or $false.

.PARAMETER allContactsFlag
    All contacts flag. $true or $false.

.PARAMETER unsubscribeFlag
    Unsubscribe flag. $true or $false.

.EXAMPLE
    New-CWMMarketingGroupCompany -parentId 3 -id 250 -defaultContactFlag $true

    Adds company 250 to marketing group 3.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMMarketingGroupCompany {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        # Route id only: parentId is never sent in the request body (groupId was, before it became an alias)
        [Parameter(Mandatory = $true)]
        [Alias('groupId')]
        [int]$parentId,
        [Alias('companyId')]
        [int]$id,
        [boolean]$defaultContactFlag,
        [boolean]$allContactsFlag,
        [boolean]$unsubscribeFlag
    )

    $Endpoint = "/marketing/groups/$($parentId)/companies"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
