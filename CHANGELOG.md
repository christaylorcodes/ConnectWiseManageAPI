# Changelog

All notable changes to ConnectWiseManageAPI will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Comprehensive GitHub community health files:
  - Issue templates for bugs, features, and questions
  - Pull request template with checklist
  - Security policy (SECURITY.md)
  - Code of Conduct (CODE_OF_CONDUCT.md)
  - Funding configuration
- Enhanced README.md with modern structure and examples
- .editorconfig for consistent code formatting across editors
- .gitattributes for proper handling of PowerShell files
- Comprehensive .gitignore for PowerShell development

- `Connect-CWM -AllowInsecureRedirect`: opt-in workaround for the PowerShell 7.4+ error
  "Cannot follow an insecure redirection by default" on New-/Update-CWM* commands against
  ConnectWise-hosted servers (#56, #70, #81, PR #58). Non-GET requests are sent with
  `-AllowInsecureRedirect -MaximumRedirection 0`, so redirects are never followed and nothing is sent over http.
  It has no effect on Windows PowerShell 5.1 or PowerShell 7.0-7.3.

### Changed
- Updated README badges with additional metrics
- `Invoke-CWMWebRequest` now gives a readable error for insecure-redirection failures, warning that the record
  may already have been created, and for redirects that are not followed.

---

## [0.4.16] - 2024-XX-XX

### Changed
- Version bump to 0.4.16

## [0.4.x] - Previous Releases

For changes in versions prior to 0.4.16, please refer to the [GitHub releases](https://github.com/christaylorcodes/ConnectWiseManageAPI/releases) and commit history.

---

## How to Use This Changelog

### Version Format
- **MAJOR.MINOR.PATCH** (e.g., 1.0.0)
  - **MAJOR**: Incompatible API changes or breaking changes
  - **MINOR**: Added functionality in a backward compatible manner
  - **PATCH**: Backward compatible bug fixes

### Categories
- **Added**: New features or functions
- **Changed**: Changes in existing functionality
- **Deprecated**: Soon-to-be removed features
- **Removed**: Removed features
- **Fixed**: Bug fixes
- **Security**: Security improvements and vulnerability fixes

### Example Entry
```markdown
## [0.5.0] - 2025-02-15

### Added
- New function `Get-CWMCustomReport` for retrieving custom reports
- Support for OAuth2 authentication
- Pipeline support for `Update-CWMTicket`

### Changed
- Improved error handling in `Invoke-CWMWebRequest`
- Updated parameter validation for `Connect-CWM`

### Fixed
- Fixed pagination issue in `Get-CWMCompany` with `-all` parameter
- Resolved authentication timeout with long-running scripts

### Security
- Updated API key storage to use secure strings
- Added input validation to prevent injection attacks
```

### Tips for Maintainers
1. **Keep unreleased changes**: Maintain an [Unreleased] section at the top for ongoing development
2. **Add dates**: Always include release dates in YYYY-MM-DD format
3. **Link issues**: Reference GitHub issues with `#123` or full URLs
4. **Group by type**: Organize changes by category (Added, Changed, Fixed, etc.)
5. **Be descriptive**: Write clear descriptions that users can understand
6. **Highlight breaking changes**: Clearly mark breaking changes in the Changed section
7. **Document functions**: List new functions added with each release

---

**Note**: Starting with version 0.4.16, we will maintain detailed changelogs for all releases. Previous versions can be reviewed through the [GitHub releases page](https://github.com/christaylorcodes/ConnectWiseManageAPI/releases).

[unreleased]: https://github.com/christaylorcodes/ConnectWiseManageAPI/compare/v0.4.16...HEAD
[0.4.16]: https://github.com/christaylorcodes/ConnectWiseManageAPI/releases/tag/0.4.16
