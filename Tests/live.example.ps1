# Connection settings for the live tests (Tests/Live.*.Tests.ps1).
# Copy this file to Tests/live.local.ps1 (gitignored) and fill it in, then run:
#     ./Tests/Invoke-Tests.ps1 -Test -Live
# Never commit real keys. Use a dedicated API member with a read-only security role unless you are
# deliberately running the write tests against a sandbox.

# Required
$env:CWMServer = 'na.myconnectwise.net'
$env:CWMCompany = 'MyCompany'
$env:CWMClientID = '00000000-0000-0000-0000-000000000000'   # from https://developer.connectwise.com/ClientID
$env:CWMAPIMemberPub = ''
$env:CWMAPIMemberPriv = ''

# Optional: extra sign-in tests skip themselves when these are empty
$env:CWMUserName = ''        # a member identifier, for impersonation (and cookie sign-in with the password)
$env:CWMUserPassword = ''    # cookie sign-in
$env:CWMPub = ''             # a member's own API keys
$env:CWMPriv = ''

# Write tests (Tests/Live.Write.Tests.ps1) create and delete records. Only on a SANDBOX server:
$env:CWMAllowWrite = 'no'    # 'yes' to run them
