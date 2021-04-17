function New-CWMTicket {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium', DefaultParameterSetName = "2020.1")]
    param(
        [string]$Version,
        [switch]$VersionAutomatic,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [int]$id,
        [Parameter(Mandatory=$true, ParameterSetName = "2020.1")]
        [Parameter(Mandatory=$true, ParameterSetName = "2019.1")]
        [ValidateLength(1,100)]
        [string]$summary,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [string]$recordType,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$board,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$status,
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$project,
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$phase,
        [Parameter(ParameterSetName = "2019.1")]
        [ValidateLength(1,50)]
        [string]$wbsCode,
        [Parameter(Mandatory=$true, ParameterSetName = "2020.1")]
        [Parameter(Mandatory=$true, ParameterSetName = "2019.1")]
        [hashtable]$company,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$site,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [ValidateLength(1,50)]
        [string]$siteName,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [ValidateLength(1,50)]
        [string]$addressLine1,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [ValidateLength(1,50)]
        [string]$addressLine2,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [ValidateLength(1,50)]
        [string]$city,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [ValidateLength(1,50)]
        [string]$stateIdentifier,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [ValidateLength(1,12)]
        [string]$zip,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$country,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$contact,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [ValidateLength(1,62)]
        [string]$contactName,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [ValidateLength(1,20)]
        [string]$contactPhoneNumber,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [ValidateLength(1,15)]
        [string]$contactPhoneExtension,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [ValidateLength(1,250)]
        [string]$contactEmailAddress,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$type,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$subType,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$item,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$team,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$owner,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$priority,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$serviceLocation,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$source,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [string]$requiredDate,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [decimal]$budgetHours,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$opportunity,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$agreement,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [ValidateSet('Low', 'Medium', 'High')]
        [string]$severity,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [ValidateSet('Low', 'Medium', 'High')]
        [string]$impact,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [ValidateLength(1,100)]
        [string]$externalXRef,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [ValidateLength(1,50)]
        [string]$poNumber,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [int]$knowledgeBaseCategoryId,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [int]$knowledgeBaseSubCategoryId,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [boolean]$allowAllClientsPortalView,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [boolean]$customerUpdatedFlag,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [boolean]$automaticEmailContactFlag,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [boolean]$automaticEmailResourceFlag,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [boolean]$automaticEmailCcFlag,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [ValidateLength(1,1000)]
        [string]$automaticEmailCc,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [string]$initialDescription,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [string]$initialInternalAnalysis,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [string]$initialResolution,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [string]$contactEmailLookup,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [boolean]$processNotifications,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [boolean]$skipCallback,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [string]$closedDate,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [string]$closedBy,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [boolean]$closedFlag,
        [string]$dateEntered,
        [string]$enteredBy,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [decimal]$actualHours,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [boolean]$approved,
        [Parameter(ParameterSetName = "2020.1")]
        [decimal]$estimatedExpenseCost,
        [Parameter(ParameterSetName = "2020.1")]
        [decimal]$estimatedExpenseRevenue,
        [Parameter(ParameterSetName = "2020.1")]
        [decimal]$estimatedProductCost,
        [Parameter(ParameterSetName = "2020.1")]
        [decimal]$estimatedProductRevenue,
        [Parameter(ParameterSetName = "2020.1")]
        [decimal]$estimatedTimeCost,
        [Parameter(ParameterSetName = "2020.1")]
        [decimal]$estimatedTimeRevenue,
        [Parameter(ParameterSetName = "2020.1")]
        [string]$billingMethod,
        [Parameter(ParameterSetName = "2020.1")]
        [decimal]$billingAmount,
        [Parameter(ParameterSetName = "2020.1")]
        [decimal]$hourlyRate,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [string]$subBillingMethod,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [decimal]$subBillingAmount,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [string]$subDateAccepted,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [string]$dateResolved,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [string]$dateResplan,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [string]$dateResponded,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [int]$resolveMinutes,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [int]$resPlanMinutes,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [int]$respondMinutes,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [boolean]$isInSla,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [int]$knowledgeBaseLinkId,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [string]$resources,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [int]$parentTicketId,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [boolean]$hasChildTicket,
        [Parameter(ParameterSetName = "2020.1")]
        [boolean]$hasMergedChildTicketFlag,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [string]$knowledgeBaseLinkType,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [string]$billTime,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [string]$billExpenses,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [string]$billProducts,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [string]$predecessorType,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [int]$predecessorId,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [boolean]$predecessorClosedFlag,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [int]$lagDays,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [boolean]$lagNonworkingDaysFlag,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [string]$estimatedStartDate,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [int]$duration,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$location,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$department,
        [Parameter(ParameterSetName = "2019.1")]
        [int]$locationId,
        [Parameter(ParameterSetName = "2019.1")]
        [int]$businessUnitId,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [guid]$mobileGuid,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$sla,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$currency,
        [Parameter(ParameterSetName = "2020.1")]
        [hashtable]$mergedParentTicket,
        [Parameter(ParameterSetName = "2020.1")]
        [string]$integratorTags,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable]$_info,
        [Parameter(ParameterSetName = "2020.1")]
        [Parameter(ParameterSetName = "2019.1")]
        [hashtable[]]$customFields
    )
    $TestVersion = @{
        VersionAutomatic = $VersionAutomatic
        ParameterSetName = $PSCmdlet.ParameterSetName
        DefaultParameterSetName = $PSCmdlet.MyInvocation.MyCommand.DefaultParameterSet
        Version = $Version
    }
    $PsBoundParameters.Version = Test-ParameterVersioning @TestVersion

    $Endpoint = '/service/tickets'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
