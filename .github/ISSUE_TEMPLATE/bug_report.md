---
name: Bug Report
about: Report a bug to help us improve
title: '[BUG] '
labels: 'bug'
assignees: ''
---

## Bug Description

A clear and concise description of what the bug is.

## Steps to Reproduce

Steps to reproduce the behavior:

1. Connect to CWM with '...'
2. Run command '...'
3. Use parameters '...'
4. See error

## Expected Behavior

A clear and concise description of what you expected to happen.

## Actual Behavior

What actually happened instead.

## Error Message

```
Paste any error messages here
```

## Environment

**Debug Report Output:**
Please run `New-CWMDebugReport` and paste the output here:

```powershell
# Output from New-CWMDebugReport
```

**Module Version:**
- ConnectWiseManageAPI Version: [e.g. 0.4.16]
- PowerShell Version: [e.g. 5.1.19041.1682]
- Operating System: [e.g. Windows 10, Linux, macOS]

**ConnectWise Environment:**
- ConnectWise Manage Version: [e.g. v2024.1]
- API Server: [e.g. na.myconnectwise.net]

## Code Sample

```powershell
# Paste the code that reproduces the issue
Connect-CWM -Server '...' -Company '...' -pubkey $pubkey -privatekey $privatekey -clientId $clientId

# Your problematic code here
```

## Additional Context

Add any other context about the problem here, such as:
- Does this happen consistently or intermittently?
- Did this work in a previous version?
- Any workarounds you've tried?

## Possible Solution

If you have a suggestion for how to fix the issue, please describe it here.
