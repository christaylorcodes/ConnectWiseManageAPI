<#
.SYNOPSIS
    Gets the configurations attached to a service ticket.

.DESCRIPTION
    Retrieves the configurations of a service ticket from ConnectWise Manage, or a single configuration by
    id. Calls GET /service/tickets/{parentId}/configurations; -id adds /{id} and -count adds /count.

.PARAMETER parentId
    The id of the service ticket.
    Alias: ticketId

.PARAMETER id
    The id of a single configuration to retrieve.

.PARAMETER count
    Return only the number of matching configurations instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "id>100".

.PARAMETER orderBy
    Sort order as 'field asc' or 'field desc', for example 'id desc'.

.PARAMETER childConditions
    Filter on child (list) fields, in condition syntax.

.PARAMETER customFieldConditions
    Filter on custom field values, in condition syntax.

.PARAMETER page
    The page number to return. Use with -pageSize.

.PARAMETER pageSize
    The number of records per page. Without it the API's default page size applies.

.PARAMETER fields
    Only return these fields, for example @('id', 'deviceIdentifier').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMTicketConfiguration -parentId 12 -condition "id>100" -all

    Retrieves the configurations of service ticket 12 that match the condition.

.EXAMPLE
    Get-CWMTicketConfiguration -parentId 12 -id 5

    Retrieves configuration 5 of service ticket 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMTicketConfiguration {
     [CmdletBinding()]
     param(
        [Parameter(Mandatory=$true)]
        [Alias('ticketId')]
        [int]$parentId,
        [int]$id,
        [switch]$count,
        [string]$condition,
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,
        [string]$childConditions,
        [string]$customFieldConditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields,
        [switch]$all
      )

     $Endpoint = "/service/tickets/$($parentId)/configurations"
     Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
  }
