<#
.SYNOPSIS
    Gets the column definitions of a ConnectWise Manage report.

.DESCRIPTION
    Retrieves the columns available on a ConnectWise Manage report and returns them as a
    single ordered dictionary of column name -> column definition.

    The API returns the column definitions as one or more objects whose properties are the
    column names. Every property of every returned object is added to the dictionary, in the
    order the API returned them. If the API returns nothing, the function returns nothing.

    This function calls the ConnectWise Manage API endpoint: GET /system/reports/{reportName}/columns

.PARAMETER Report
    The name of the report to get the columns of (as listed by Get-CWMReport).

.EXAMPLE
    Get-CWMReportColumn -Report 'Service'

    Returns an ordered dictionary of the columns of the 'Service' report, keyed by column name.

.EXAMPLE
    $Columns = Get-CWMReportColumn -Report 'Service'
    $Columns.Keys

    Lists only the column names of the 'Service' report.

.NOTES
    The output is a System.Collections.Specialized.OrderedDictionary, so columns keep the
    order the API returned them in. Use it like a hashtable ($Columns['id'], $Columns.Keys).

.LINK
    Get-CWMReport

.LINK
    https://developer.connectwise.com/Products/ConnectWise_PSA/REST
#>
function Get-CWMReportColumn {
    [CmdletBinding()]
    [OutputType([System.Collections.Specialized.OrderedDictionary])]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Report
    )

    $Endpoint = "/system/reports/$([uri]::EscapeDataString($Report))/columns"

    $Result = Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
    if (!$Result) { return }

    $HashTable = [ordered]@{}
    foreach ($Item in @($Result)) {
        if ($null -eq $Item) { continue }
        foreach ($Property in $Item.PSObject.Properties) {
            $HashTable[$Property.Name] = $Property.Value
        }
    }

    if ($HashTable.Count -eq 0) { return }
    $HashTable
}
