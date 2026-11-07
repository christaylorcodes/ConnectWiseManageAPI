<h1 align="center">
  <br>
  <img src=".\Media\Manage-RGB-Horiz-Master.png" alt="logo"></a>
  <br>
  ConnectWise Manage REST API
  <br>
</h1>

<h4 align="center">

A comprehensive PowerShell wrapper for the [ConnectWise Manage REST API](https://developer.connectwise.com/Products/Manage/REST)

</h4>

<div align="center">

[![CI](https://github.com/christaylorcodes/ConnectWiseManageAPI/actions/workflows/ci.yml/badge.svg)](https://github.com/christaylorcodes/ConnectWiseManageAPI/actions/workflows/ci.yml)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/8aa3633cda3d41d5baa5e9f595b8124f)](https://www.codacy.com/gh/christaylorcodes/ConnectWiseManageAPI/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=christaylorcodes/ConnectWiseManageAPI&amp;utm_campaign=Badge_Grade)
[![Gallery](https://img.shields.io/powershellgallery/v/ConnectWiseManageAPI?label=PS%20Gallery&logo=powershell&logoColor=white)](https://www.powershellgallery.com/packages/ConnectWiseManageAPI)
[![Downloads](https://img.shields.io/powershellgallery/dt/ConnectWiseManageAPI?label=Downloads&logo=powershell)](https://www.powershellgallery.com/packages/ConnectWiseManageAPI)
[![License](https://img.shields.io/github/license/christaylorcodes/ConnectWiseManageAPI)](LICENSE)
[![Donate](https://img.shields.io/badge/$-donate-ff69b4.svg?maxAge=2592000&amp;style=flat)](https://github.com/christaylorcodes/GitHub-Template/blob/main/DONATE.md)

</div>

<p align="center">
    <a href="#-features">Features</a> •
    <a href="#-installation">Installation</a> •
    <a href="#-quick-start">Quick Start</a> •
    <a href="ConnectWiseManageAPI_Functions.md">Functions</a> •
    <a href="https://github.com/christaylorcodes/ConnectWiseManageAPI/tree/master/Examples">Examples</a> •
    <a href="https://github.com/christaylorcodes/ConnectWiseManageAPI/wiki">Wiki</a> •
    <a href="CONTRIBUTING.md">Contributing</a>
</p>

---

## 📋 Table of Contents

- [Features](#-features)
- [Installation](#-installation)
- [Quick Start](#-quick-start)
- [Usage Examples](#-usage-examples)
- [Upgrading to 0.5.0](#-upgrading-to-050)
- [Troubleshooting](#-troubleshooting)
- [Available Functions](#-available-functions)
- [Requirements](#-requirements)
- [Contributing](#-contributing)
- [Support](#-support)
- [License](#-license)

## ✨ Features

This module makes it easy to leverage PowerShell to automate tasks in ConnectWise Manage:

- **220+ Cmdlets** covering all major API endpoints
- **Automated Pagination** for large result sets
- **Advanced Filtering** using ConnectWise condition syntax
- **Retry Logic** for transient errors (reads only, so a retry never creates a duplicate)
- **Object Output** that works with the PowerShell pipeline (Where-Object, Select-Object, Export-Csv)
- **Built-in Help** for every function (Get-Help <function> -Full), with examples for the most-used ones
- **Cross-Platform**: PowerShell 7 on Windows, Linux and macOS, and Windows PowerShell 5.1

## 📦 Installation

### From PowerShell Gallery (Recommended)

```powershell
Install-Module 'ConnectWiseManageAPI' -Scope CurrentUser
```

### Update to Latest Version

```powershell
Update-Module 'ConnectWiseManageAPI'
```

> **Note:** If you're having issues accessing the PowerShell Gallery, check out this [repair script](https://github.com/christaylorcodes/Initialize-PSGallery)

## 🚀 Quick Start

### Prerequisites

> **Important:** As of August 14, 2019, ConnectWise requires a [Client ID](https://developer.connectwise.com/ClientID) to interact with the API.

### Authentication

```powershell
# Connect to ConnectWise Manage
Connect-CWM -Server 'na.myconnectwise.net' `
            -Company 'YourCompany' `
            -pubkey $publicKey `
            -privatekey $privateKey `
            -clientId $clientId
```

For detailed authentication options and setup, see the [Authentication Wiki](https://github.com/christaylorcodes/ConnectWiseManageAPI/wiki/Getting-Started---Authentication).

## 💡 Usage Examples

### Working with Tickets

```powershell
# Get all open tickets
Get-CWMTicket -condition "status/name='Open'" -all

# Create a new ticket
$ticketParams = @{
    summary = 'Issue reported via PowerShell'
    board = @{ id = 1 }
    company = @{ id = 123 }
    status = @{ id = 456 }
}
New-CWMTicket @ticketParams

# Update one field of a ticket
Update-CWMTicket -id 12345 -Operation replace -Path status -Value @{ id = 789 }

# Update several fields in one request
Update-CWMTicket -id 12345 -PatchOperations @(
    @{ op = 'replace'; path = 'status'; value = @{ id = 789 } }
    @{ op = 'replace'; path = 'summary'; value = 'Updated from PowerShell' }
)
```

### Working with Companies

```powershell
# Search for companies by type (types is a list, so use -childConditions)
Get-CWMCompany -childConditions "types/name='Partner'" -all

# Get company with specific ID
Get-CWMCompany -id 123

# Create a new company (look up the type ID with Get-CWMCompanyType)
$companyParams = @{
    identifier = 'ACME'
    name = 'ACME Corporation'
    types = @(@{ id = 1 })
}
New-CWMCompany @companyParams
```

### Working with Time Entries

```powershell
# Get time entries for a date range
Get-CWMTimeEntry -condition "timeStart > [2024-01-01] and timeStart < [2024-01-31]" -all

# Create a new time entry
$timeParams = @{
    company = @{ id = 123 }
    chargeToType = 'ServiceTicket'
    chargeToId = 12345
    timeStart = (Get-Date) | ConvertTo-CWMTime -Raw
    timeEnd = (Get-Date).AddHours(2) | ConvertTo-CWMTime -Raw
    member = @{ identifier = 'JDoe' }
}
New-CWMTimeEntry @timeParams
```

More examples available in the [Examples](https://github.com/christaylorcodes/ConnectWiseManageAPI/tree/master/Examples) directory.

## 🔄 Upgrading to 0.5.0

0.5.0 has breaking changes. The main ones:

- **PowerShell 5.1 or later is required** (was 3.0).
- **The module always uses the server's current API version.** `Connect-CWM -Version` is removed; remove it from your scripts.
- **New-CWMTicket** no longer takes `-Version`, `-VersionAutomatic`, `-project`, `-phase`, `-wbsCode`, `-locationId`, `-businessUnitId`, `-dateEntered` or `-enteredBy`. Create project tickets with `New-CWMProjectTicket`.
- **`Connect-CWM -MemberID` now really impersonates** the member (0.4.16 silently used the API key).
- A few parameters and aliases the API did not accept were removed, some route ids are now mandatory, and positional binding shifted on four functions. Use named parameters.

See the [CHANGELOG](CHANGELOG.md) for the full list and migration hints.

## 🔧 Troubleshooting

### PowerShell 7.4+ and "Cannot follow an insecure redirection"

On PowerShell 7.4 and later, create and update calls (`New-CWM*`, `Update-CWM*`) against some ConnectWise-hosted servers can fail with *"Cannot follow an insecure redirection by default"*. The server's response carries an `http://` Location header, usually on a request it has **already processed**, so the record may exist even though you saw an error.

Connect with the opt-in `-AllowInsecureRedirect` switch:

```powershell
Connect-CWM -Server 'na.myconnectwise.net' -Company 'YourCompany' `
            -pubkey $publicKey -privatekey $privateKey -clientId $clientId `
            -AllowInsecureRedirect
```

With the switch, PowerShell accepts that response, but the module never follows a redirect on a create or update (nothing is sent over http). If the server sends a real redirect, you get an error saying it was not followed and that the record may already exist. The switch has no effect on Windows PowerShell 5.1 or PowerShell 7.0-7.3, which do not raise this error. Whenever you see either error, check whether the record was created before you retry.
## 📚 Available Functions

The module includes 220+ cmdlets organized by functional area:

| Category | Functions |
|----------|-----------|
| **Service** | Tickets, Service Boards, Ticket Notes, Configurations, Knowledge Base, Service Templates |
| **Company** | Companies, Contacts, Sites, Teams |
| **Time** | Time Entries, Time Sheets |
| **Project** | Projects, Phases, Team Members, Project Tickets |
| **Finance** | Agreements, Billing, Invoices |
| **System** | Members, Audit Trail, Documents |
| **Sales** | Opportunities, Activities |
| **Marketing** | Marketing Groups |
| **Procurement** | Products, Inventory, Purchase Orders |
| **Schedule** | Calendar Entries, Holidays |

For a complete list of available functions, see [ConnectWiseManageAPI_Functions.md](ConnectWiseManageAPI_Functions.md).

## 📋 Requirements

- **PowerShell Version:** PowerShell 5.1 or later. PowerShell 7.4+ is recommended (Windows, Linux and macOS); Windows PowerShell 5.1 is still supported. Both are tested on every change.
- **ConnectWise Manage:** Active instance with API access
- **API Credentials:** Public/Private API keys and Client ID
- **Dependencies:** None (self-contained module)

## 🔒 Security

For reporting security vulnerabilities, please see our [Security Policy](SECURITY.md).

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**!

### How to Contribute

1. **Star this repository** ⭐ - It helps others discover the project
2. **Report bugs** - Use the [bug report template](.github/ISSUE_TEMPLATE/bug_report.md)
3. **Suggest features** - Use the [feature request template](.github/ISSUE_TEMPLATE/feature_request.md)
4. **Submit pull requests** - See our [Contributing Guide](CONTRIBUTING.md)
5. **Share your work** - Show us what you've built!

**Want to share something you created using the module?** Submit it to be featured as a Community Package.

Please read our [Contributing Guidelines](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## 📖 Tutorials & Blog Posts

In-depth tutorials on [christaylor.codes](https://christaylor.codes):

| Tutorial | Description |
|----------|-------------|
| [Introducing ConnectWiseManageAPI](https://christaylor.codes/powershell/psa/connectwisemanageapi/2024/09/16/introducing-connectwisemanageapi.html) | Module overview, architecture, and key features |
| [Getting Started](https://christaylor.codes/powershell/psa/connectwisemanageapi/2024/09/23/getting-started-connectwisemanageapi.html) | Authentication, setup, and first API calls |
| [Advanced Automation](https://christaylor.codes/powershell/psa/connectwisemanageapi/2024/09/30/advanced-automation-connectwisemanageapi.html) | Complex workflows and real-world automation scenarios |
| [Best Practices](https://christaylor.codes/powershell/psa/connectwisemanageapi/2024/10/07/best-practices-connectwisemanageapi.html) | Production deployment patterns and performance tips |

## 💬 Support

### Getting Help

- 📖 Check the [Wiki](https://github.com/christaylorcodes/ConnectWiseManageAPI/wiki) for detailed documentation
- 🐛 [Report bugs](https://github.com/christaylorcodes/ConnectWiseManageAPI/issues/new?template=bug_report.md)
- 💡 [Request features](https://github.com/christaylorcodes/ConnectWiseManageAPI/issues/new?template=feature_request.md)
- 📧 [Browse existing issues](https://github.com/christaylorcodes/ConnectWiseManageAPI/issues)

### Show Your Support

If this project has helped you, please consider:

- ⭐ Starring the repository
- 🐦 Sharing it on social media
- 💰 [Sponsoring the project](https://github.com/christaylorcodes/GitHub-Template/blob/main/DONATE.md)

Your support enables continued development and maintenance of this project!

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- ConnectWise for providing the Manage API
- The MSPGeek community for feedback and support
- All contributors who have helped improve this module

---

<div align="center">

**[⬆ back to top](#connectwise-manage-rest-api)**

Made with ❤️ by [Chris Taylor](https://christaylor.codes)

</div>
