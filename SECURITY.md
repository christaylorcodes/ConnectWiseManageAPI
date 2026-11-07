# Security Policy

## Supported versions

Only the latest release on the [PowerShell Gallery](https://www.powershellgallery.com/packages/ConnectWiseManageAPI) receives fixes.

## Reporting a vulnerability

Please don't open a public issue for security problems. Report them privately through
[GitHub's private vulnerability reporting](https://github.com/christaylorcodes/ConnectWiseManageAPI/security/advisories/new)
and include the steps to reproduce and the affected version.

This is a volunteer-maintained project, so there is no guaranteed response time.

## Handling credentials

- Never paste API keys, passwords or session cookies into issues. `New-CWMDebugReport` leaves them out.
- Verbose, debug and `-WhatIf` output masks password, token and key values, but review it before you share it.
