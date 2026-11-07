# ConnectWiseManageAPI - Codebase Documentation

## Project Overview

**ConnectWiseManageAPI** is a PowerShell module that provides a comprehensive wrapper for the ConnectWise Manage REST API. ConnectWise Manage is a professional services automation (PSA) platform used by managed service providers (MSPs) and IT service companies.

- **Version:** 0.4.16
- **License:** MIT
- **Author:** Chris Taylor (@ChrisTaylorCodes)
- **Language:** PowerShell 3.0+
- **Repository:** https://github.com/christaylorcodes/ConnectWiseManageAPI

## Purpose

This module allows PowerShell users to:
- Automate interactions with ConnectWise Manage
- Manage tickets, companies, contacts, time entries, projects, and more
- Integrate ConnectWise Manage data with other systems
- Build custom workflows and automation scripts

## Architecture

### Design Pattern

The module uses a **"Master Function"** pattern where specific endpoint functions call generic master functions:

```
User Function (e.g., Get-CWMTicket)
    ↓
Master Function (Invoke-CWMGetMaster or Invoke-CWMSearchMaster)
    ↓
Web Request Handler (Invoke-CWMWebRequest)
    ↓
ConnectWise Manage REST API
```

### Directory Structure

```
ConnectWiseManageAPI/
├── ConnectWiseManageAPI/          # Main module directory
│   ├── ConnectWiseManageAPI.psm1  # Module entry point (dot-sources all functions)
│   ├── ConnectWiseManageAPI.psd1  # Module manifest with metadata
│   ├── ConnectWiseManageAPI.Format.ps1xml  # Custom object formatting
│   ├── Private/                   # Internal helper functions (not exported)
│   │   ├── ConvertFrom/          # Conversion utilities
│   │   └── Helper/               # URL building, parameter testing
│   └── Public/                    # Exported functions (180+ cmdlets)
│       ├── Authentication/        # Connect/Disconnect
│       ├── Company/              # Company, contact, site operations
│       ├── Finance/              # Agreement and billing operations
│       ├── Helper/               # User-facing utilities
│       ├── Invoke/               # Master invoke functions (core API layer)
│       ├── Marketing/            # Marketing group operations
│       ├── Procurement/          # Product, inventory, PO operations
│       ├── Project/              # Project management operations
│       ├── Sales/                # Opportunities and activities
│       ├── Schedule/             # Calendar and scheduling
│       ├── Service/              # Service tickets and boards
│       ├── System/               # System info, members, audits
│       └── Time/                 # Time entries and timesheets
├── Docs/                         # Function documentation (80+ markdown files)
├── Examples/                     # Usage examples
└── Tests/                        # Pester tests
```

## Core Components

### 1. Authentication ([Public/Authentication/](ConnectWiseManageAPI/Public/Authentication/))

- **[Connect-CWM.ps1](ConnectWiseManageAPI/Public/Authentication/Connect-CWM.ps1)** - Establishes API connection
  - Supports API key authentication, cookie authentication, and member impersonation
  - Stores credentials in script-scoped variables
  - Validates connection and retrieves system info

- **[Disconnect-CWM.ps1](ConnectWiseManageAPI/Public/Authentication/Disconnect-CWM.ps1)** - Clears connection credentials

### 2. Master Invoke Functions ([Public/Invoke/](ConnectWiseManageAPI/Public/Invoke/))

These are the core API interaction functions that all endpoint-specific functions call:

- **[Invoke-CWMWebRequest.ps1](ConnectWiseManageAPI/Public/Invoke/Invoke-CWMWebRequest.ps1)** - Low-level HTTP request handler
  - Handles authentication headers
  - Implements retry logic for 5xx errors
  - Manages request/response serialization
  - Error handling and logging

- **[Invoke-CWMGetMaster.ps1](ConnectWiseManageAPI/Public/Invoke/Invoke-CWMGetMaster.ps1)** - Generic GET requests
  - Supports pagination, filtering, sorting
  - Handles custom fields and child conditions

- **[Invoke-CWMSearchMaster.ps1](ConnectWiseManageAPI/Public/Invoke/Invoke-CWMSearchMaster.ps1)** - Search endpoint handler
  - Uses POST for complex queries

- **[Invoke-CWMNewMaster.ps1](ConnectWiseManageAPI/Public/Invoke/Invoke-CWMNewMaster.ps1)** - Generic POST requests (create)

- **[Invoke-CWMUpdateMaster.ps1](ConnectWiseManageAPI/Public/Invoke/Invoke-CWMUpdateMaster.ps1)** - Generic PATCH/PUT requests (update)

- **[Invoke-CWMRemoveMaster.ps1](ConnectWiseManageAPI/Public/Invoke/Invoke-CWMRemoveMaster.ps1)** - Generic DELETE requests

- **[Invoke-CWMAllResult.ps1](ConnectWiseManageAPI/Public/Invoke/Invoke-CWMAllResult.ps1)** - Pagination handler
  - Automatically retrieves all pages of results
  - Used when `-all` switch is specified

### 3. Private Helper Functions ([Private/Helper/](ConnectWiseManageAPI/Private/Helper/))

- **[New-CWMUrl.ps1](ConnectWiseManageAPI/Private/Helper/New-CWMUrl.ps1)** - Constructs API URLs with query parameters
- **[Join-Url.ps1](ConnectWiseManageAPI/Private/Helper/Join-Url.ps1)** - Joins URL path segments
- **[Test-ParameterVersioning.ps1](ConnectWiseManageAPI/Private/Helper/Test-ParameterVersioning.ps1)** - Validates API version compatibility

### 4. Endpoint-Specific Functions

Each functional area has dedicated cmdlets that follow PowerShell verb-noun conventions:

#### Service Management ([Public/Service/](ConnectWiseManageAPI/Public/Service/))
- Tickets: `Get-CWMTicket`, `New-CWMTicket`, `Update-CWMTicket`, `Remove-CWMTicket`
- Service Boards: `Get-CWMServiceBoard`, `Get-CWMServiceBoardStatus`, `Get-CWMServiceBoardType`
- Ticket Notes: `Get-CWMTicketNote`, `New-CWMTicketNote`, `Update-CWMTicketNote`, `Remove-CWMTicketNote`
- Ticket Configurations: `Get-CWMTicketConfiguration`, `New-CWMTicketConfiguration`, `Remove-CWMTicketConfiguration`

#### Company Management ([Public/Company/](ConnectWiseManageAPI/Public/Company/))
- Companies: `Get-CWMCompany`, `New-CWMCompany`, `Update-CWMCompany`, `Remove-CWMCompany`
- Contacts: `Get-CWMContact`, `New-CWMContact`, `Update-CWMContact`, `Remove-CWMContact`
- Company Sites: `Get-CWMCompanySite`, `New-CWMCompanySite`, `Update-CWMCompanySite`
- Configurations: `Get-CWMCompanyConfiguration`, `New-CWMCompanyConfiguration`

#### Time Management ([Public/Time/](ConnectWiseManageAPI/Public/Time/))
- Time Entries: `Get-CWMTimeEntry`, `New-CWMTimeEntry`, `Update-CWMTimeEntry`, `Remove-CWMTimeEntry`
- Time Sheets: `Get-CWMTimeSheet`, `Update-CWMTimeSheet`, `Submit-CWMTimeSheet`, `Remove-CWMTimeSheet`

#### Project Management ([Public/Project/](ConnectWiseManageAPI/Public/Project/))
- Projects: `Get-CWMProject`, `Update-CWMProject`
- Project Phases, Team Members, Tickets

#### Finance ([Public/Finance/](ConnectWiseManageAPI/Public/Finance/))
- Agreements: `Get-CWMAgreement`, `New-CWMAgreement`, `Update-CWMAgreement`

#### System ([Public/System/](ConnectWiseManageAPI/Public/System/))
- Members: `Get-CWMSystemMember`, `New-CWMSystemMember`, `Update-CWMSystemMember`
- Audit Trail: `Get-CWMAuditTrail`
- Documents: `Get-CWMDocument`, `New-CWMDocument`, `Update-CWMDocument`
- System Info: `Get-CWMSystemInfo`

## Common Patterns

### Standard Parameters (Get Functions)

Most GET functions support these parameters:
- `condition` - Filter using CWM condition syntax (e.g., "status/name='Open'")
- `orderBy` - Sort results (e.g., "id desc")
- `childConditions` - Filter child records
- `customFieldConditions` - Filter by custom fields
- `page`, `pageSize` - Pagination control
- `fields` - Select specific fields to return
- `all` - Switch to retrieve all results automatically
- `count` - Switch to return only count of matching records

### Condition Syntax

ConnectWise Manage uses a specific condition syntax for filtering:
```powershell
# Simple condition
"status/name='Open'"

# Multiple conditions
"status/name='Open' and company/id=123"

# Operators: =, !=, <, >, <=, >=, contains, like
"summary contains 'urgent'"
```

### Common Update Pattern

Update operations typically use patch objects:
```powershell
$Operations = @(
    @{
        op = 'replace'
        path = 'status'
        value = @{ id = 123 }
    }
)
Update-CWMTicket -TicketID 456 -Operation $Operations
```

## Authentication Flow

1. User calls `Connect-CWM` with credentials
2. Module stores credentials in script-scoped variables:
   - `$script:CWMServerConnection` - Connection info object
   - Contains: Server, AuthString, ClientID, Headers, OverrideVersion
3. Every API call includes authentication headers
4. `Disconnect-CWM` clears these variables

## Error Handling

- All API calls wrapped in try/catch blocks
- Retry logic for HTTP 5xx errors (server errors)
- Detailed error messages with API response content
- Connection validation before API calls
- Parameter validation using PowerShell parameter attributes

## Testing

- **Framework:** Pester (PowerShell testing framework)
- **Location:** [Tests/ConnectWiseManageAPI.Tests.ps1](Tests/ConnectWiseManageAPI.Tests.ps1)
- **CI/CD:** AppVeyor
- **Coverage:** Authentication, parameter validation, API interactions

## Key Files Reference

| File | Purpose |
|------|---------|
| [ConnectWiseManageAPI.psm1](ConnectWiseManageAPI/ConnectWiseManageAPI.psm1) | Module loader - dot-sources all functions |
| [ConnectWiseManageAPI.psd1](ConnectWiseManageAPI/ConnectWiseManageAPI.psd1) | Module manifest with version and exports |
| [Connect-CWM.ps1](ConnectWiseManageAPI/Public/Authentication/Connect-CWM.ps1) | Establishes API connection |
| [Invoke-CWMWebRequest.ps1](ConnectWiseManageAPI/Public/Invoke/Invoke-CWMWebRequest.ps1) | Core HTTP request handler |
| [Invoke-CWMGetMaster.ps1](ConnectWiseManageAPI/Public/Invoke/Invoke-CWMGetMaster.ps1) | Generic GET handler |
| [New-CWMUrl.ps1](ConnectWiseManageAPI/Private/Helper/New-CWMUrl.ps1) | URL construction |

## Development Guidelines

### Adding New Endpoints

1. Create function in appropriate `Public/` subdirectory
2. Use appropriate master invoke function (`Invoke-CWMGetMaster`, etc.)
3. Follow parameter naming conventions
4. Include comment-based help with `.SYNOPSIS`, `.DESCRIPTION`, `.EXAMPLE`
5. Add to exported functions in manifest if public
6. Add documentation in `Docs/` directory
7. Update function reference in `ConnectWiseManageAPI_Functions.md`

### Coding Standards

- Use approved PowerShell verbs (Get, New, Update, Remove, etc.)
- Prefix all functions with `CWM`
- Include parameter validation attributes
- Support `-WhatIf` and `-Confirm` for destructive operations
- Follow PowerShell best practices and style guide (see [CONTRIBUTING.md](CONTRIBUTING.md))

### Documentation Process

This module uses **comment-based help** as the single source of truth for all function documentation. The markdown files in the [Docs/](Docs/) directory are auto-generated from the comment-based help in the `.ps1` source files using the PlatyPS module.

#### Comment-Based Help Structure

All public functions must include comment-based help following this structure:

```powershell
<#
.SYNOPSIS
    Brief one-line description of the function.

.DESCRIPTION
    Detailed description of what the function does, how it works,
    and any important behavioral notes. Include information about:
    - What the function accomplishes
    - How it interacts with the API
    - Any important prerequisites or dependencies
    - Performance considerations

.PARAMETER ParameterName
    Description of what this parameter does and how to use it.
    Include valid values, examples, and any special formatting.

.EXAMPLE
    Example-Command -Parameter "Value"

    Description of what this example demonstrates.

.NOTES
    Author: Chris Taylor
    Date: YYYY-MM-DD

    Additional notes about:
    - Internal implementation details
    - Performance considerations
    - Version requirements
    - Related ConnectWise Manage API endpoints

.LINK
    Related-Function

.LINK
    https://developer.connectwise.com/...
#>
function Verb-CWMNoun {
    # Function implementation
}
```

#### Documentation Template

A comprehensive documentation template is available at [Templates/FunctionDocumentation.template.ps1](Templates/FunctionDocumentation.template.ps1). This template includes:
- Complete structure for all comment-based help sections
- Common parameter documentation patterns
- Multiple example patterns for different scenarios
- Best practices for writing clear, helpful documentation

#### Regenerating Markdown Documentation

After updating comment-based help in any `.ps1` file, regenerate the markdown documentation using PlatyPS:

```powershell
# 1. Import the module with latest changes
Import-Module 'c:\_Code\ConnectWiseManageAPI\ConnectWiseManageAPI\ConnectWiseManageAPI.psd1' -Force

# 2. Import PlatyPS
Import-Module PlatyPS -Force

# 3. Regenerate all markdown files
Update-MarkdownHelp -Path 'c:\_Code\ConnectWiseManageAPI\Docs' -UpdateInputOutput -UseFullTypeName -Force
```

**Important Notes:**
- Always regenerate markdown after modifying comment-based help
- The `-Force` parameter ensures all files are updated, even if no changes are detected
- `UpdateInputOutput` ensures parameter and output information is refreshed
- The markdown files in `Docs/` should **never** be manually edited
- Commit both the `.ps1` source files and regenerated markdown files together

#### Documentation Workflow

When adding or updating function documentation:

1. **Edit the `.ps1` source file** - Add or update the comment-based help block
2. **Use the template** - Reference [Templates/FunctionDocumentation.template.ps1](Templates/FunctionDocumentation.template.ps1) for structure
3. **Include examples** - Provide practical, real-world usage examples
4. **Document all parameters** - Explain purpose, valid values, and usage patterns
5. **Add notes** - Include API endpoint information, performance tips, version requirements
6. **Regenerate markdown** - Run `Update-MarkdownHelp` to update the `Docs/` directory
7. **Test the help** - Verify with `Get-Help Function-Name -Full`
8. **Commit both files** - Commit the source `.ps1` and generated `.md` files together

#### Best Practices

- **Be comprehensive but concise** - Provide all necessary information without redundancy
- **Include multiple examples** - Show basic usage, advanced scenarios, and pipeline examples
- **Document common pitfalls** - Warn users about potential issues or limitations
- **Reference related functions** - Use `.LINK` to connect related functionality
- **Keep it current** - Update documentation when behavior changes
- **Use consistent terminology** - Match ConnectWise Manage's naming conventions
- **Test your examples** - Ensure all code examples actually work

## Common Tasks

### Creating a Ticket
```powershell
Connect-CWM -Server 'na.myconnectwise.net' -Company 'MyCompany' -pubkey $pubkey -privatekey $privatekey -clientId $clientId

$Ticket = @{
    summary = 'New ticket from PowerShell'
    board = @{ id = 1 }
    company = @{ id = 123 }
}
New-CWMTicket @Ticket
```

### Searching Companies
```powershell
Get-CWMCompany -condition "types contains 'Partner'" -all
```

### Updating a Contact
```powershell
$Update = @(
    @{
        op = 'replace'
        path = 'email'
        value = 'newemail@example.com'
    }
)
Update-CWMContact -ContactID 456 -Operation $Update
```

## Dependencies

- **PowerShell Version:** 3.0 or higher
- **Assemblies:** System.Web (for URL encoding)
- **External Modules:** None (self-contained)
- **API Requirements:** ConnectWise Manage server and API credentials

## Resources

- **Main Documentation:** [README.md](README.md)
- **Function Reference:** [ConnectWiseManageAPI_Functions.md](ConnectWiseManageAPI_Functions.md)
- **Examples:** [Examples/](Examples/)
- **Contributing Guide:** [CONTRIBUTING.md](CONTRIBUTING.md)
- **PowerShell Gallery:** https://www.powershellgallery.com/packages/ConnectWiseManageAPI
- **GitHub Issues:** https://github.com/christaylorcodes/ConnectWiseManageAPI/issues

## Version History

Current version: **0.4.16** (latest commit: e7f0842)

The module is actively maintained with regular updates for new API endpoints and bug fixes.