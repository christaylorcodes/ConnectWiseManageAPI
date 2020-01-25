function Get-CWMTicketConfiguration {
     [CmdletBinding()]
     param(
         [Parameter(Mandatory=$true)]
         [int]$TicketID,
         [int]$page,
         [int]$pageSize,
         [switch]$all
     )
     $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/service/tickets/$TicketID/configurations"
     return Invoke-CWMGetMaster -Arguments $PsBoundParameters -URI $URI
 }
