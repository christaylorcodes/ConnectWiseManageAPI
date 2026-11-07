<#
.SYNOPSIS
    Replaces a service template resource in ConnectWise Manage.

.DESCRIPTION
    Replaces a whole service template resource (PUT). Properties that are not specified may be
    cleared by the API. To change only some properties, use Update-CWMServiceTemplateResource.

    This function calls the ConnectWise Manage API endpoint: PUT /service/templates/{parentId}/resources/{id}

.PARAMETER parentId
    The ID of the service template (required).
    Alias: templateId

.PARAMETER id
    The ID of the resource to replace (required).
    Alias: resourceId

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
    Set-CWMServiceTemplateResource -parentId 15 -id 3 -member @{ identifier = 'jdoe' } -hours 1.5 -isTicketOwner $true

    Replaces resource 3 of service template 15.

.NOTES
    Endpoint: PUT /service/templates/{parentId}/resources/{id}

    Based on PR #82 by mdewart-Centre.

.LINK
    Get-CWMServiceTemplateResource

.LINK
    Update-CWMServiceTemplateResource

.LINK
    Invoke-CWMSetMaster

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the replaced service template resource.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Set-CWMServiceTemplateResource {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('templateId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [Alias('resourceId')]
        [int]$id,
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

    $Endpoint = "/service/templates/$($parentId)/resources/$($id)"
    Invoke-CWMSetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
