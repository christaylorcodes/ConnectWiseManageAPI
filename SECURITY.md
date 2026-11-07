# Security Policy

## Supported Versions

We release patches for security vulnerabilities. Currently supported versions:

| Version | Supported          |
| ------- | ------------------ |
| 0.4.x   | :white_check_mark: |
| < 0.4.0 | :x:                |

## Reporting a Vulnerability

The ConnectWiseManageAPI team takes security bugs seriously. We appreciate your efforts to responsibly disclose your findings.

### How to Report a Security Vulnerability

**Please do not report security vulnerabilities through public GitHub issues.**

Instead, please report them via one of the following methods:

1. **GitHub Security Advisories** (Preferred)
   - Navigate to the repository's Security tab
   - Click "Report a vulnerability"
   - Fill out the security advisory form with details

2. **Direct Email**
   - Send details to the repository maintainer (see [GitHub profile](https://github.com/christaylorcodes) for contact info)
   - Use the subject line: `[SECURITY] ConnectWiseManageAPI - Brief Description`

3. **Private Message on Slack**
   - Contact **@CTaylor** on [MSPGeek Slack](https://join.mspgeek.com/)
   - Clearly mark the message as security-related

### What to Include

Please include the following information in your report to help us better understand and resolve the issue:

- **Type of issue** (e.g., code injection, privilege escalation, information disclosure)
- **Full paths of source file(s)** related to the manifestation of the vulnerability
- **Location of the affected source code** (tag/branch/commit or direct URL)
- **Step-by-step instructions to reproduce the issue**
- **Proof-of-concept or exploit code** (if possible)
- **Impact of the issue**, including how an attacker might exploit it
- **Any special configuration required** to reproduce the issue
- **Your assessment of severity** (Critical, High, Medium, Low)

### Response Timeline

- **Initial Response**: We will acknowledge receipt of your vulnerability report within 48 hours
- **Assessment**: We will assess the vulnerability and provide an estimated timeline for a fix within 7 days
- **Fix Development**: Critical vulnerabilities will be prioritized and addressed as quickly as possible
- **Disclosure**: Once a fix is available, we will coordinate disclosure with you

### Security Best Practices

When using ConnectWiseManageAPI:

#### Credential Management

- **Never hardcode credentials** in your scripts
- Store API keys and secrets securely using:
  - Windows Credential Manager
  - Secret management tools (Azure Key Vault, AWS Secrets Manager, etc.)
  - Environment variables (for development only)
- Use the `-Credential` parameter where available
- Regularly rotate API keys

```powershell
# Good: Use secure credential storage
$credential = Get-Credential
$pubkey = $credential.UserName
$privatekey = $credential.GetNetworkCredential().Password

# Bad: Never do this!
# $pubkey = "hardcoded-key"
# $privatekey = "hardcoded-secret"
```

#### Network Security

- Always use HTTPS endpoints
- Verify SSL certificates
- Use Client IDs as required by ConnectWise
- Implement proper network segmentation

#### Access Control

- Use principle of least privilege for API keys
- Create dedicated API members with minimal required permissions
- Audit API access regularly
- Disable or remove unused API keys

#### Logging and Monitoring

- Be cautious with logging to prevent credential exposure
- Sanitize logs before sharing
- Monitor for unusual API activity
- Use the debug features responsibly

#### Module Updates

- Keep the module updated to the latest version
- Subscribe to repository notifications for security updates
- Review release notes for security-related changes

### Known Security Considerations

#### API Key Exposure

- API keys stored in `$CWMServerConnection` are in memory during the session
- Use `Disconnect-CWM` to clear credentials when done
- Be careful when sharing scripts or debug output

#### Injection Risks

- The module uses condition strings that could be vulnerable to injection
- Always validate and sanitize user input before using in conditions
- Use parameterized queries where possible

```powershell
# Risky: Direct user input in conditions
$userInput = Read-Host "Enter company name"
Get-CWMCompany -condition "name='$userInput'"  # Potential injection

# Better: Validate input first
$userInput = Read-Host "Enter company name"
if ($userInput -match '^[a-zA-Z0-9\s-]+$') {
    Get-CWMCompany -condition "name='$userInput'"
} else {
    Write-Error "Invalid input"
}
```

## Security Updates

Security updates will be released as patch versions and announced via:

- GitHub Security Advisories
- GitHub Releases
- Repository notifications

## Bug Bounty Program

We do not currently offer a paid bug bounty program, but we deeply appreciate security researchers who help keep ConnectWiseManageAPI and its users safe.

## Questions

If you have questions about this security policy, please open a public issue or contact the maintainer.

---

**Last Updated**: January 2025
