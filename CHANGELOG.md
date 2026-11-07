# Changelog

## [Unreleased]

### Added
- `Connect-CWM -AllowInsecureRedirect`: opt-in workaround for the PowerShell 7.4+ error
  "Cannot follow an insecure redirection by default" on New-/Update-CWM* commands against
  ConnectWise-hosted servers (#56, #70, #81, PR #58). Non-GET requests are sent with
  `-AllowInsecureRedirect -MaximumRedirection 0`, so redirects are never followed and nothing is sent over http.
  It has no effect on Windows PowerShell 5.1 or PowerShell 7.0-7.3.

### Changed
- `Invoke-CWMWebRequest` now gives a readable error for insecure-redirection failures, warning that the record
  may already have been created, and for redirects that are not followed.
