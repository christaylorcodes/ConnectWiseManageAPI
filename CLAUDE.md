# ConnectWiseManageAPI - Codebase Notes

PowerShell module wrapping the ConnectWise Manage (PSA) REST API. MIT, by Chris Taylor
(@ChrisTaylorCodes). Repo: <https://github.com/christaylorcodes/ConnectWiseManageAPI>.
The version lives in the manifest ([ConnectWiseManageAPI.psd1](ConnectWiseManageAPI/ConnectWiseManageAPI.psd1));
don't copy it into this file.

**Runtime:** Windows PowerShell 5.1 and PowerShell 7 (`CompatiblePSEditions` Desktop + Core). Every change
must run on both. No external module dependencies.

## Architecture

Endpoint functions are thin wrappers that build an endpoint path and hand their arguments to a master function:

```text
Get-CWMCompany / New-CWMTicket / ...        (Public/<Area>/)
    -> Invoke-CWM<Verb>Master               (Public/Invoke/)
        -> Invoke-CWMWebRequest             (auth headers, retries, errors)
            -> ConnectWise Manage REST API
```

| Master | HTTP | Used by |
| --- | --- | --- |
| `Invoke-CWMGetMaster` | GET (`/{id}`, `/count`, conditions, paging, `-all` via `Invoke-CWMAllResult`) | `Get-*` |
| `Invoke-CWMSearchMaster` | POST `.../search` | `Get-CWMTicket` list queries |
| `Invoke-CWMNewMaster` | POST (JSON body) | `New-*` |
| `Invoke-CWMUpdateMaster` | PATCH (JSON Patch) | `Update-*` |
| `Invoke-CWMSetMaster` | PUT (full replace) | `Set-*` |
| `Invoke-CWMRemoveMaster` | DELETE | `Remove-*` |
| `Invoke-CWMActionMaster` | POST, no body (action endpoints such as `/submit`, `/link`) | action functions |

Layout: `ConnectWiseManageAPI/` holds the psm1 (dot-sources everything, sets TLS on 5.1), the psd1, the
format file, `Private/` (URL building, JSON conversion, request-body building, retry helpers; not exported)
and `Public/<Area>/` (Authentication, Company, Finance, Helper, Invoke, Marketing, Procurement, Project,
Sales, Schedule, Service, System, Time). `Docs/` and `ConnectWiseManageAPI/en-US/` are generated;
`Examples/`, `Templates/`, `Tests/` and `Tools/` are at the repo root.

`Connect-CWM` stores the connection in `$script:CWMServerConnection` (Server, Codebase, BasePath, Headers,
...); `Disconnect-CWM` clears it.

- **Retries:** write requests (POST/PATCH/PUT/DELETE) are never retried on 5xx. Reads and searches
  (`ReadOnly`) retry on 502/503/504; any method retries on 429. See `Test-CWMRetryable`.
- **API version:** the module always targets the server's current CW API (read at connect); there is no
  version pinning. Check endpoints against the spec with `./Tools/Test-CWMApiCoverage.ps1`.

## Conventions

- Approved verbs, `CWM` noun prefix. Destructive and write functions declare
  `SupportsShouldProcess, ConfirmImpact = 'Medium'`; the master does the `ShouldProcess` call.
- Route ids are named `grandparentId`, `parentId`, `id` (the body builder drops `parentId`/`grandparentId`).
  Friendly names (`companyId`, `ticketId`, ...) are aliases. A route id the URL can't do without is
  `Mandatory`, otherwise the URL silently gets a `0`.
- Get parameters must use the names the masters read: `id`, `count`, `condition`, `orderBy`,
  `childConditions`, `customFieldConditions`, `page`, `pageSize`, `pageId`, `fields`, `all`. Anything else
  is silently ignored, so keep old spellings only as aliases.
- Don't modify `$PSBoundParameters`. When arguments need reshaping, copy them into a hashtable first:
  `$Arguments = @{}; foreach ($Key in $PSBoundParameters.Keys) { $Arguments[$Key] = $PSBoundParameters[$Key] }`
- String values interpolated into an endpoint path or query string go through `[uri]::EscapeDataString()`.
  Int-typed values don't need it.
- Query-string parameters that the masters don't know (for example `type` on `/system/audittrail`) are
  built by the function itself, with `/count` placed before the `?`.
- `Update-*` functions have two parameter sets: `Single` (`-Operation -Path -Value`, positional after the
  route ids) and `Bulk` (`-PatchOperations`). See `Templates/Update-CWMTemplate.ps1`.
- `Templates/` has Get, New, Update and Remove templates. `Set-*` (PUT) and action functions have no template:
  copy an existing one, for example `Set-CWMServiceTemplateResource` or `Update-CWMTimeSheet`.

### Usage reference

```powershell
Connect-CWM -Server 'na.myconnectwise.net' -Company 'MyCompany' -pubkey $pubkey -privatekey $privatekey -clientId $clientId

Get-CWMCompany -condition "status/name='Active' and name contains 'Acme'" -orderBy 'id desc' -all
# List fields (e.g. a company's types) are filtered with -childConditions, not -condition
Get-CWMCompany -childConditions 'types/id=1' -all
New-CWMTicket -summary 'From PowerShell' -board @{ id = 1 } -company @{ id = 123 }

# One change
Update-CWMTicket -id 456 -Operation replace -Path 'status' -Value @{ id = 123 }
# Several changes in one request
Update-CWMCompanyContact -id 456 -PatchOperations @(
    @{ op = 'replace'; path = 'firstName'; value = 'Ann' }
    @{ op = 'replace'; path = 'title'; value = 'CTO' }
)
```

## Documentation

Comment-based help in the `.ps1` file is the source of truth. It is **required for every new or changed
public function** (not every existing function has it yet). Use
[Templates/FunctionDocumentation.template.ps1](Templates/FunctionDocumentation.template.ps1): `.SYNOPSIS`,
`.DESCRIPTION` (include the API endpoint), `.PARAMETER` for each parameter, at least one `.EXAMPLE`, and
`.NOTES`/`.LINK` where useful. Don't invent API constraints or dates.

`Docs/*.md` and `ConnectWiseManageAPI/en-US/` are generated with PlatyPS; never hand-edit them. Regenerate
after help changes and commit the source and generated files together:

```powershell
Import-Module ./ConnectWiseManageAPI/ConnectWiseManageAPI.psd1 -Force
Import-Module PlatyPS -Force
Update-MarkdownHelp -Path ./Docs -UpdateInputOutput -UseFullTypeName -Force
./Tools/Remove-PlatyPSProgressAction.ps1   # strips the -ProgressAction noise PlatyPS adds on PowerShell 7.4+
```

## Adding an endpoint

1. Add the function under `Public/<Area>/`, starting from the matching template.
2. Run `pwsh -File ./Tools/Update-CWMManifestExport.ps1` to update `FunctionsToExport`.
3. Add an offline test (method + URL, plus body checks where relevant) to `Tests/Endpoints.Tests.ps1`.
4. Run `pwsh ./Tools/Test-CWMApiCoverage.ps1`; it checks method, path and body properties against the
   ConnectWise OpenAPI spec and must report 0 issues.
5. Regenerate docs, and update `ConnectWiseManageAPI_Functions.md` and `CHANGELOG.md`.

## Testing and checks

Pester 5, fully offline (`Invoke-WebRequest` is mocked; see `Tests/Helpers/TestSetup.ps1`). Run on both shells:

```powershell
pwsh -NoProfile -File ./Tests/Invoke-Tests.ps1 -Test
powershell -NoProfile -File ./Tests/Invoke-Tests.ps1 -Test
Invoke-ScriptAnalyzer -Path ./ConnectWiseManageAPI -Recurse -Settings ./PSScriptAnalyzerSettings.psd1
```

CI: GitHub Actions (`.github/workflows/ci.yml`): Windows PowerShell 5.1 and pwsh on Windows, pwsh on Ubuntu.

## Resources

[README.md](README.md) · [ConnectWiseManageAPI_Functions.md](ConnectWiseManageAPI_Functions.md) ·
[CONTRIBUTING.md](CONTRIBUTING.md) · [CHANGELOG.md](CHANGELOG.md) · [Examples/](Examples/) ·
[PowerShell Gallery](https://www.powershellgallery.com/packages/ConnectWiseManageAPI)
