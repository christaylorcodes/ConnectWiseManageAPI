<#
.SYNOPSIS
    Assigns a resource to a service template in ConnectWise Manage.

.DESCRIPTION
    Assigns a resource (member) to a service template.

    This function calls the ConnectWise Manage API endpoint: POST /service/templates/{parentId}/resources

.PARAMETER parentId
    The ID of the service template (required).
    Alias: templateId

.PARAMETER serviceTemplate
    The service template reference, e.g. @{ id = 15 }.

.PARAMETER member
    The member reference, e.g. @{ id = 140 } or @{ identifier = 'jdoe' }.

.PARAMETER startDateTime
    The start date and time, as an ISO 8601 string, e.g. '2026-01-05T14:00:00Z'.

.PARAMETER endDateTime
    The end date and time, as an ISO 8601 string.

.PARAMETER hours
    The scheduled hours.

.PARAMETER scheduleStatus
    The schedule status reference, e.g. @{ id = 2 }.

.PARAMETER location
    The schedule location reference, e.g. @{ id = 1 }.

.PARAMETER reminderFlag
    Sets reminderFlag.

.PARAMETER reminderMinutes
    Sets reminderMinutes.

.PARAMETER isTicketOwner
    Sets isTicketOwner.

.PARAMETER timeZone
    The time zone reference, e.g. @{ id = 1 }.

.PARAMETER endAfter
    Sets endAfter.

.PARAMETER recurrence
    The recurrence object, passed through to the request body.

.PARAMETER _info
    The _info metadata object, passed through to the request body.

.EXAMPLE
    New-CWMServiceTemplateResource -parentId 15 -member @{ identifier = 'jdoe' } -isTicketOwner $true

    Assigns member jdoe to service template 15 as the ticket owner.

.EXAMPLE
    New-CWMServiceTemplateResource -templateId 15 -member @{ id = 140 } -hours 2 -WhatIf

    Shows the request that would be sent without creating anything.

.NOTES
    Endpoint: POST /service/templates/{parentId}/resources

    Based on PR #82 by mdewart-Centre.

.LINK
    Get-CWMServiceTemplateResource

.LINK
    Set-CWMServiceTemplateResource

.LINK
    Update-CWMServiceTemplateResource

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the created service template resource.
#>
function New-CWMServiceTemplateResource {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('templateId')]
        [int]$parentId,
        [hashtable]$serviceTemplate,
        [hashtable]$member,
        [string]$startDateTime,
        [string]$endDateTime,
        [double]$hours,
        [hashtable]$scheduleStatus,
        [hashtable]$location,
        [bool]$reminderFlag,
        [int]$reminderMinutes,
        [bool]$isTicketOwner,
        [hashtable]$timeZone,
        [int]$endAfter,
        [hashtable]$recurrence,
        [hashtable]$_info
    )

    $Endpoint = "/service/templates/$($parentId)/resources"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
