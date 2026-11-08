# Changelog

All notable changes to ConnectWiseManageAPI will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.5.0] - YYYY-MM-DD

PowerShell 7 is now the primary edition; Windows PowerShell 5.1 is still supported and tested.
This release has **breaking changes**. Read them before upgrading.

### Breaking changes

- **PowerShell 5.1 or later is required** (was 3.0). On WMF 4/5.0, stay on 0.4.16 or upgrade WMF.
- **The module always targets the server's current API version.** `Connect-CWM -Version` is removed. Connect-CWM
  reads the version from `/system/info`, and every request pins the Accept header to it (0.4.16 sent no version
  unless you passed `-Version`). Response models now match the server's current API. If a script reads a field
  that older API versions returned, check it against the current model.
  *Migration:* remove `-Version` from your `Connect-CWM` calls.
- **New-CWMTicket** no longer has `-Version`, `-VersionAutomatic`, `-project`, `-phase`, `-wbsCode`, `-locationId`,
  `-businessUnitId`, `-dateEntered` or `-enteredBy`.
  *Migration:* create project tickets with the new `New-CWMProjectTicket` (#43). Drop the other parameters; the
  API sets or ignores them.
- **Removed parameters that the API does not accept** (they were ignored or rejected by the server):
  - `New-CWMProductCatalog -dateEntered`;
  - `New-CWMMember -TimeZoneSetupReference`, `-remotePackage`, `-remotePackagePlatform`, `-remotePackageUserName`,
    `-remotePackagePassword` and `-remotePackageAccount`;
  - `-id` on `Get-CWMTicketAllNote` (the all-notes endpoint has no single-note route).
- **Positional binding shifted** because of the removals and new route ids. If you pass these by position, switch to
  named parameters:
  - `Get-CWMTicketAllNote`: `-condition` and the parameters after it moved up one position (no `-id`).
  - `New-CWMMember`: the parameters after `-timeZone` moved up one, and the ones after
    `-agreementInvoicingDisplayOptions` moved up six.
  - `New-CWMProductCatalog`: the parameters after `-integrationXRef` moved up one.
  - `Get-CWMProductAdjustmentDetail`: the new mandatory `-parentId` is position 0, so `-id` is now position 1.
  - `New-CWMProjectTicketConfiguration`: `-_info` moved from position 2 to 3 (new `-deviceIdentifier`).
- **Wrong aliases removed or replaced:**
  - `Remove-CWMDocument`: `-somethingId` is now `-documentId`;
  - `Update-CWMProductAdjustment`: `-catalogId` is now `-adjustmentId`;
  - `Update-CWMPurchaseOrder`: `-catalogId` is now `-purchaseOrderId`;
  - `Get-CWMCompanyCountry`: the misleading `-companyId` alias is removed.
- **Route ids are now mandatory** where a missing id built a broken URL: `Get-CWMCompanyTeam -parentId`,
  `Get-CWMProductAdjustmentDetail -parentId`, `New-/Update-/Remove-CWMProductPickingShippingDetail -parentId`,
  `New-CWMMarketingGroupCompany -parentId` (alias `-groupId`), `New-CWMMemberToken -memberIdentifier`,
  `New-CWMOpportunityForecastItem -id` (it defaulted to 0, which posted to `/forecast/0`), and the ticket ids of
  `New-CWMTicketChild`.
- **Parameter types now match the API:**
  - `New-CWMProductCatalog -priceAttribute` takes `FixedFee`, `NotToExceed`, `OverrideRate` or `TimeAndMaterials`
    (it was an `[int]`, which the API rejects);
  - `New-CWMTicketConfiguration` and `New-CWMProjectTicketConfiguration`: `-id` is an `[int]`, and
    `-deviceIdentifier` is its own parameter, sent as `deviceIdentifier` (it was an alias of `-id`);
  - `Get-CWMSSOConfiguration -id` is an `[int]`, as in the API;
  - `New-CWMCompanyContact -country` is a reference such as `@{ id = 1 }`; a country name string no longer binds.
- **`Connect-CWM -MemberID` now really impersonates the member.** 0.4.16 silently connected with the API key
  instead. Check what the impersonated member is allowed to do before relying on it.
- **An `add` or `replace` update without a value now errors** instead of silently sending `null`. Pass
  `-Value $null` explicitly to clear a field. `New-CWMTicketChild` also errors when `-OperationType` does not match
  the parameters (a merge without `-StatusID` used to send status 0).
- **`New-CWMDocument` uploads are private by default.** The `PrivateFlag` part header was malformed (missing
  closing quote), so the server most likely ignored it and applied its own default. Now `-Private` (default `$true`)
  reaches the server. *Migration:* pass `-Private $false` for documents that customers should see.

### Added

- **`-PatchOperations` on every `Update-CWM*` function**, to change several fields in one PATCH request (#53). The
  existing `-Operation/-Path/-Value` form still works, and `-Value` is optional for `remove`.
- **`Connect-CWM -AllowInsecureRedirect`**: opt-in workaround for the PowerShell 7.4+ error "Cannot follow an
  insecure redirection" on create and update calls against ConnectWise-hosted servers (#56, #70, #81, PR #58).
  Redirects are never followed, so nothing is sent over http. No effect on 5.1 or 7.0-7.3.
- **Knowledge base:** `Get-`, `New-`, `Update-` and `Remove-CWMKnowledgeBaseArticle` (#59).
- **Project tickets:** `New-CWMProjectTicket` (posts to `/project/tickets`, so the ticket lands on the project) (#43)
  and `Get-CWMProjectTicketAllNote`.
- **Company service templates** (from PR #82): `Get-`, `New-`, `Set-`, `Update-`, `Remove-` and
  `Copy-CWMCompanyServiceTemplate`, `Add-` and `Remove-CWMCompanyServiceTemplateLink`, and
  `Invoke-CWMCompanyServiceTemplateGenerate`.
- **Service templates:** `Get-CWMServiceTemplate`, and `Get-`, `New-`, `Set-` and `Update-CWMServiceTemplateResource`.
- **Tickets:** `Remove-CWMTicketChild` unbundles child tickets through `/detachChildren` (#34).
- **Other getters:** `Get-CWMInvoice` and `Get-CWMOpportunityNote`.
- **Master functions:** `Invoke-CWMSetMaster` (PUT) and `Invoke-CWMActionMaster` (bodyless POST actions), for
  endpoints that have no wrapper yet.
- `New-CWMProjectTicket` accepts `-workRole`, `-workType`, `-location` and `-department`.
- Examples: `Set-CWMConfigurationLastUser.ps1` (#79), `Get-TicketsForConfiguration.ps1` (#38), and an optional lunch
  window in `TimeSucks.ps1`.
- Comment-based help for every public function (`Get-Help <function> -Full`), and regenerated `Docs/`.
- **`Get-CWMDocument -download -OutFile`** saves a document to disk. Without `-OutFile` the content is returned as
  a `byte[]`.
- **User-Agent** `ConnectWiseManageAPI/<version> PowerShell/<version>` on every request, so ConnectWise can identify
  the module's traffic.
- **29 new endpoint functions** (checked against the 2026.11 OpenAPI spec):
  - Custom fields: `Get-`, `New-`, `Update-` and `Remove-CWMUserDefinedField` (`/system/userDefinedFields`).
  - Agreements: `Get-`, `New-`, `Update-` and `Remove-CWMAgreementAdjustment`, `-CWMAgreementWorkRole` and
    `-CWMAgreementWorkType` (`/finance/agreements/{id}/adjustments`, `/workroles`, `/worktypes`).
  - Invoices: `New-CWMInvoice`, `Update-CWMInvoice`, and `Get-CWMInvoice -id <n> -pdf [-OutFile]` for the invoice PDF.
  - Ticket children: `Get-CWMTicketTimeEntry`, `Get-CWMTicketScheduleEntry`, `Get-CWMTicketDocument` and
    `Get-CWMTicketProduct`. They return full records from `/time/entries`, `/schedule/entries`, `/system/documents`
    and `/procurement/products`, not the id-only `/service/tickets/{id}/...` endpoints the API documentation
    redirects from.
  - Lookups: `Get-CWMWorkRole`, `Get-CWMWorkType`, `Get-CWMExpenseType`, `Get-CWMConfigurationStatus` and
    `Get-CWMWorkflow`.
  - Expenses: `Update-CWMExpenseEntry` and `Remove-CWMExpenseEntry`.

### Changed

- **`-all` asks for 1000 records per page** (the API maximum; was 999) and keeps a smaller `-pageSize` if you
  pass one. Paging follows the `rel="next"` entry of the `Link` header instead of the first link.
- **`[datetime]` values in request bodies and patch values are sent as ISO 8601 UTC** (`2026-01-02T03:04:05Z`) on
  both editions. Windows PowerShell 5.1 sent `\/Date(ms)\/`; PowerShell 7 sent local dates with their offset and dates
  without a kind with no offset. Local dates (for example `Get-Date`) are converted to UTC. Dates without a kind (for
  example `[datetime]'2026-01-02'`) are sent unchanged as UTC, as PowerShell 7 sent them, so a calendar date keeps its
  day. String parameters are sent as given.
- **Retry policy.** Reads (GET/HEAD) and searches retry on 502, 503 and 504; every method retries on 429. Writes
  (POST/PATCH/PUT/DELETE) are never retried on a 5xx, so a retry can't create a duplicate. The wait honours
  `Retry-After`, otherwise it backs off 2, 4, 8, 16 and 32 seconds (about 62 seconds in total over 5 retries).
  (0.4.16's retry loop never actually ran.)
- **Error messages** include the ConnectWise error code and message, field-level validation errors, and the HTTP
  status. The wording of earlier versions is kept, but the error id suffix is now `,Write-CWMWebRequestError`
  (was `,Invoke-CWMWebRequest`). Update scripts that match on `FullyQualifiedErrorId`. Redirect errors say
  whether the record may already have been created (#70).
- **Connect-CWM reconnects on its own** when the server, company, sign-in method or member differs from the current
  connection; `-Force` is only needed to refresh the same connection. A failed connect leaves no partial state:
  a failed `-Force` reconnect as the same identity keeps the previous, unexpired connection, and any other failed
  connect clears it.
- **`Connect-CWM -Server`** accepts a pasted URL (reduced to the host), `host:port` and hostnames with underscores.
  Hosts that contain user info, `?`, `#` or `\` are rejected.
- **Redaction:** password, token, private key, secret and memberHash values are masked in debug, verbose and
  `-WhatIf` output. `New-CWMDebugReport` omits headers, the session and errors.
- Some request fields use their API schema names; the old names still work as aliases: `billSeparateFlag`,
  `mobileGuid`, `_info`, `New-CWMCompanyTeam -location/-department`, and
  `New-CWMCompanyContact -managerContact/-assistantContact`.
- `Disconnect-CWM` also clears the cookie session, and does nothing quietly when you are not connected.
- `Submit-CWMTimeSheet` calls `Update-CWMTimeSheet -Submit` and supports `-WhatIf`.
- `Tests/Invoke-Tests.ps1` writes its results to `TestResults/` (one file pair per PowerShell version, overwritten
  each run) instead of timestamped files in the repo root.
- **Live tests** (opt-in, never in CI): `Tests/Live.Read.Tests.ps1` is read-only and safe on production; it calls
  every `Get-*` function and checks conditions, ordering, fields, counts and paging. `Tests/Live.Write.Tests.ps1`
  creates, changes and deletes `PSTEST` records on a sandbox server and also needs `$env:CWMAllowWrite = 'yes'`.
  Run them with `./Tests/Invoke-Tests.ps1 -Test -Live`, using settings in the gitignored `Tests/live.local.ps1`
  (copy `Tests/live.example.ps1`). `Tools/Remove-CWMTestData.ps1` finds and removes records left by an interrupted
  run. These replace `Tests/ConnectWiseManageAPI.Tests.ps1`.
- New offline tests: `Tests/Conventions.Tests.ps1` (approved verbs, complete help, ShouldProcess on writes, Get
  parameters the masters read, manifest aliases) and `Tests/GetSmoke.Tests.ps1` (every `Get-*` sends one
  well-formed request). `Invoke-Tests.ps1` also counts failed blocks and files as failures.
- `Tools/Update-CWMManifestExport.ps1` also keeps `AliasesToExport` in sync with the `[Alias()]` attributes.
- CI runs on `integration/**` branches, cancels superseded runs, has a job timeout and uses actions v7.
  Dependabot keeps the actions current, and a weekly workflow checks every endpoint against a pinned, reviewed
  copy of a community-maintained ConnectWise OpenAPI spec
  (covenanttechnologysolutions/connectwise-rest).

### Fixed

- **`Get-CWMDocument -download` returns the file.** It used to parse the file as JSON and fail.
- **`Connect-CWM` uses the server's codebase** for the impersonation token and cookie login requests (they were
  hard-coded to `v4_6_release`, which broke on-premises servers with another codebase), and sends the `ClientID`
  header to `/login/companyinfo`.
- **A response that is not JSON no longer comes back as a result object** from `Get-*` functions; only the error is
  written.
- **Nine functions that were never exported** (their files had plural names) can now be called:
  `Get-`, `New-` and `Update-CWMAgreementType`, `Get-`, `New-`, `Update-` and `Remove-CWMProductPickingShippingDetail`,
  `Get-CWMOpportunityStage` and `Get-CWMOpportunityStatus`.
- Windows PowerShell 5.1 sends request bodies as UTF-8, so non-Latin-1 text is no longer mangled (#78; diagnosis by
  AndreasMoe).
- `Update-CWM*` with a PSCustomObject `-Value` (for example `$ticket.board`) sends the object instead of `{}`.
- `-all` on 5.1 returns a flat list instead of nested per-page arrays.
- `-count` works on `Get-CWMAuditTrail` and `Get-CWMDocument`.
- URL bugs: `Update-`/`Remove-CWMProductPickingShippingDetail` sent a literal `{parentId}`;
  `Get-CWMProductAdjustmentDetail` always called `//details`; `New-CWMMarketingGroupCompany` sent the group id in
  the body; `New-CWMAgreementType` posted to the wrong path; path casing on `warehouseBins`, `inventoryOnHand`,
  `holidayLists`, `myMembers`, `mySecurity` and `allNotes`.
- `Get-CWMReportColumn` no longer fails on an uninitialized result (#65).
- `New-CWMTicketChild` bundles and merges correctly; the nested status is serialized (#34).
- `New-CWMDocument` uploads are byte-exact (they were corrupted on PowerShell 7.4+).
- `Update-CWMTimeSheet` no longer sends its action switches in the request body.
- `Get-CWMContactType` applies its filter, and `New-CWMCompanyContact -portalPassword` works.
- `Invoke-CWMGetMaster` and `Invoke-CWMSearchMaster` no longer pick up `$id`/`$URLParameters` from the caller's
  scope, and the masters no longer return a stale `$Result` under `-WhatIf`.
- Clearer help for `New-`/`Update-CWMCompanyConfigurationTypeQuestionValue`: they edit a question's allowed values,
  not a configuration's answer (#45).
- `TimeSucks.ps1` example: the scheduled task duration no longer drops minutes (#23).
- **Money and quantity values keep their precision.** Decimal parameters were single-precision `[float]` (and
  `New-CWMOpportunity -totalSalesTax` an `[int]`), so 1234567.89 was sent as 1234567.9. They are `[double]` now.
- Parameters the API takes as arrays accept arrays: `-customFields`, `New-CWMProductAdjustment -adjustmentDetails`,
  `-serialNumberIds`, `-serialNumbers` and `New-CWMTicket -integratorTags`. `New-CWMMember` accepts `Email`, `TEL` and
  `CALLTO`; `New-CWMTimeEntry -chargeToType` accepts `Company`.
- `New-CWMCompanyConfiguration -backupBillableSpaceGb` keeps its decimals. `Get-CWMOpportunity`,
  `Get-CWMOpportunityStatus` and `Get-CWMOpportunityStage` take `-id` and `-count`.
- `New-CWMCompanyNote` no longer sends the company id in the request body. Its route id is `-parentId`;
  `-companyId` and `-id` still work.
- `Get-CWMReport` escapes the report name; `Get-CWMOpportunity*` send an array `-fields` correctly.
- `ConvertTo-CWMTime` uses the invariant culture (other cultures could produce dates the API rejects).
- `Connect-CWM` connects again when `-ClientID` or `-BasePath` changes, instead of keeping the old values.
- `New-CWMDocument -FilePath` resolves relative paths against the current PowerShell location.
- `New-CWMAgreementType -Confirm` prompts once. `New-CWMDebugReport` hashes with SHA-256 (MD5 fails under FIPS).

### Security

- `-all` paging only follows next-page links on the connected host and port, with no https-to-http downgrade, so
  credentials are never sent to another host. A link that fails the check stops the call with a terminating
  error rather than returning a partial result.
- `Connect-CWM` validates `-Server` and escapes `-Company` and `-MemberID`; cookie sessions use Secure cookies and a
  stale cookie session is reset.
- Secrets are masked in debug, verbose and `-WhatIf` output, and kept out of `New-CWMDebugReport`.
- `-AllowInsecureRedirect` never follows a redirect (`-MaximumRedirection 0`).
- `New-CWMDocument` sanitizes multipart header values; string values in URL paths are escaped.

### Contributors

Thanks to mdewart-Centre (PR #82), jadamwilson (PR #77), epiphanyplx (PR #79), damiankw (fixes inspired by PRs #71
and #76) and AndreasMoe (diagnosis of #78).

## [0.4.16] - 2025-08-26

### Changed

- Version bump to 0.4.16

## [0.4.x] - Previous Releases

For changes in versions prior to 0.4.16, please refer to the [commit history](https://github.com/christaylorcodes/ConnectWiseManageAPI/commits/master) and the [PowerShell Gallery version history](https://www.powershellgallery.com/packages/ConnectWiseManageAPI).

[0.5.0]: https://www.powershellgallery.com/packages/ConnectWiseManageAPI/0.5.0
[0.4.16]: https://www.powershellgallery.com/packages/ConnectWiseManageAPI/0.4.16
