<#
Template for Update-CWM* (PATCH) functions.

Pattern (issue #53):
- Two parameter sets:
    'Single' (default): -Operation, -Path and -Value, all mandatory. One change per request, as before.
    'Bulk':             -PatchOperations, mandatory. Several changes in one request.
- Route ids (grandparentId, parentId, id) have no ParameterSetName, so they are in both sets.
- Positions are explicit, route ids first, so positional calls keep working:
      Update-CWMTicket 1 replace summary 'New summary'
  With a parentId the positions shift: parentId = 0, id = 1, Operation = 2, Path = 3, Value = 4.
  PatchOperations has no position.
- Pass $PsBoundParameters to Invoke-CWMUpdateMaster. It checks PatchOperations first; when present,
  those operations are the whole body and Operation/Path/Value are not used.
- PatchOperations is [object[]] so both hashtables and PSCustomObjects are accepted:
      @{ op = 'replace'; path = 'summary'; value = 'New' }
      [pscustomobject]@{ op = 'remove'; path = 'contact' }
  'value' is left out of 'remove' operations by Invoke-CWMUpdateMaster.

Fill in <Noun>, <Endpoint> and the comment-based help. Do not invent API constraints or dates.
#>
<#
.SYNOPSIS
    Updates a <Noun> in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing <Noun>.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH <Endpoint>/{id}

.PARAMETER id
    The ID of the <Noun> to update (required).

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change.

.PARAMETER Value
    The new value for the property.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value.

.EXAMPLE
    Update-CWMTemplate -id 1 -Operation replace -Path 'name' -Value 'New name'

    Replaces the name of <Noun> 1.

.EXAMPLE
    Update-CWMTemplate 1 replace name 'New name'

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMTemplate -id 1 -PatchOperations @(
        @{ op = 'replace'; path = 'name'; value = 'New name' }
        @{ op = 'remove'; path = 'description' }
    )

    Changes the name and clears the description of <Noun> 1 in one request.

.NOTES
    Endpoint: PATCH <Endpoint>/{id}

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated <Noun>.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Update-CWMTemplate {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [int]$id,
        [Parameter(Mandatory = $true, Position = 1, ParameterSetName = 'Single')]
        [validateset('add', 'replace', 'remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true, Position = 2, ParameterSetName = 'Single')]
        [string]$Path,
        [Parameter(Mandatory = $true, Position = 3, ParameterSetName = 'Single')]
        $Value,
        [Parameter(Mandatory = $true, ParameterSetName = 'Bulk')]
        [ValidateNotNullOrEmpty()]
        [object[]]$PatchOperations
    )

    $Endpoint = '<Endpoint>'
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
