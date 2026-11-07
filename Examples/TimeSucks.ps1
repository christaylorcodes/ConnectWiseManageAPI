<#
    .SYNOPSIS
    If a time entry has not been created within time frame this will prompt for time.

    .DESCRIPTION
    This script will create a scheduled task that checks for latest time entry every 5 minutes.
    If a time entry has not been created in the specified time frame a prompt will display where they can enter time.

    On first run the script copies itself to %APPDATA%\TimeSucks\TimeSucks.ps1, opens the config template in
    Notepad, asks for your Manage API keys and creates the scheduled task. The task runs that local copy hidden
    (conhost --headless) as the current user, with normal (not elevated) rights, only while you are logged on.

    The script does not update itself. To update, download the example again and run it once; it copies itself
    over the installed copy. Run Update-Module ConnectWiseManageAPI to update the module.

    Data, config and log live in %APPDATA%\TimeSucks:
    - TimeSucks.xml   config, with the API keys stored as a PSCredential (Export-Clixml, current user and machine only)
    - TimeSucks.log   log of the most recent run

    Config settings (edited in Notepad on first run):
    - ScheduledStart      The time your shift starts in 24hr format.
    - ScheduledEnd        The time your shift ends in 24hr format.
    - ManageUser          Your Manage username.
    - TimeFrame           How long you can go without entering a time entry in minutes. 0 removes the scheduled task.
    - LunchStart          Optional. The time your lunch break starts in 24hr format, e.g. '12:00'. Leave empty to disable.
                          No prompt is shown during lunch, and the lunch break itself does not count against TimeFrame.
    - LunchEnd            Optional. The time your lunch break ends in 24hr format, e.g. '13:00'. Leave empty to disable.
    - AutoClose           Close the GUI after you hit 'Submit'.
    - TimeWrapChargeCode  The charge code to use when using the 'TimeWrap' option.
    - TaskName            The name of the scheduled task that will get created.
    - CWMConnectionInfo   Server (the URL for your CW Manage server), Company (the company used when logging in
                          to Manage) and ClientID (https://developer.connectwise.com/ClientID).

    The public and private API keys are asked for separately:
    https://github.com/christaylorcodes/ConnectWiseManageAPI/wiki/Getting-Started---Authentication#api-keys

    To start over, delete %APPDATA%\TimeSucks\TimeSucks.xml.

    .EXAMPLE
    .\TimeSucks.ps1

    First run: installs the script, asks for the config and creates the scheduled task.

    .EXAMPLE
    .\TimeSucks.ps1 -Verbose

    Shows the log lines on screen as well as writing them to the log file.

    .NOTES
    Version:        0.1
    Author:         Chris Taylor
    Creation Date:  4/20/2017
    Purpose/Change: Initial script development

    Version:        0.2
    Author:         Chris Taylor
    Creation Date:  9/14/2020
    Purpose/Change: Updated to work with ConnectWiseManageAPI module

    Version:        0.3
    Purpose/Change: Optional lunch break (LunchStart/LunchEnd), scheduled task duration keeps minutes

    Version:        0.4
    Purpose/Change: Removed the remote logging helper, the downloads and the auto-update; built-in log file;
                    the scheduled task runs the local copy hidden via conhost --headless, without elevation.
                    The AutoUpdate config setting is no longer used. Updates come from re-downloading this example.

#>
[CmdletBinding()]
param()

$Version = '0.4'

$ScriptName = 'TimeSucks'
$Quotes = 'All your time are belong to us!','Time keeps on slipping slipping, into the future.','Time is money.','Time waits for no one.','Lost time is never found again.'

$ScriptDir = Join-Path $env:APPDATA $ScriptName
$ScriptPath = Join-Path $ScriptDir "$ScriptName.ps1"
$LogPath = Join-Path $ScriptDir "$ScriptName.log"
$ConfigPath = Join-Path $ScriptDir "$ScriptName.xml"
$null = New-Item -Path $ScriptDir -ItemType Directory -Force

function Write-TSLog {
    param(
        [Parameter(Mandatory)][string]$Message,
        [ValidateSet('Info', 'Error')][string]$Level = 'Info'
    )
    $Line = '{0:yyyy-MM-dd HH:mm:ss} [{1}] {2}' -f (Get-Date), $Level.ToUpper(), $Message
    Write-Verbose $Line
    Add-Content -Path $LogPath -Value $Line -ErrorAction SilentlyContinue
}

#Exit if already open
$ThisProcess = Get-CimInstance -ClassName Win32_Process -Filter "ProcessId=$PID"
$AlreadyRunning = Get-CimInstance -ClassName Win32_Process -Filter "Name='powershell.exe'" | Where-Object { $_.CommandLine -eq $ThisProcess.CommandLine -and $_.ProcessId -ne $PID }
if ($AlreadyRunning) {
    Write-TSLog 'Already running, exiting.'
    exit
}

#Start a fresh log for this run
Set-Content -Path $LogPath -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') [INFO] $ScriptName $Version started." -ErrorAction SilentlyContinue

$MinimumVersion = '0.3.5.0'
if (-not (Get-Module ConnectWiseManageAPI -ListAvailable | Where-Object { $_.Version -ge $MinimumVersion })) {
    Install-Module ConnectWiseManageAPI -Force
}
Import-Module ConnectWiseManageAPI -MinimumVersion $MinimumVersion

function Test-Time{
    param($Time)
    try{[datetime]$Time}
    catch{$false}
}

function Get-LunchAdjustedTime{
    # Returns InLunch (skip the prompt) and the LastTimeEntry to use, max(LastTimeEntry, today's LunchEnd) after lunch.
    # Lunch is disabled when LunchStart/LunchEnd are empty, missing (older configs) or invalid.
    param(
        [datetime]$LastTimeEntry,
        $LunchStart,
        $LunchEnd,
        [datetime]$Now = (Get-Date)
    )
    $Result = [pscustomobject]@{ InLunch = $false; LastTimeEntry = $LastTimeEntry }
    if(!$LunchStart -or !$LunchEnd){ return $Result }
    $StartTime = Test-Time $LunchStart
    $EndTime = Test-Time $LunchEnd
    if(!$StartTime -or !$EndTime){ return $Result }
    $Start = $Now.Date + $StartTime.TimeOfDay
    $End = $Now.Date + $EndTime.TimeOfDay
    if($End -le $Start){ return $Result }
    if($Now -ge $Start -and $Now -lt $End){ $Result.InLunch = $true }
    elseif($Now -ge $End -and $LastTimeEntry -lt $End){ $Result.LastTimeEntry = $End }
    $Result
}

function Save-Config {
    param(
        $Template,
        $Path
    )
    $TempConfig = Join-Path $env:TEMP 'TempConfig.json'
    $Template | ConvertTo-Json | Out-File $TempConfig -Force
    Start-Process notepad -ArgumentList $TempConfig -Wait
    $Config = Get-Content $TempConfig | ConvertFrom-Json
    Remove-Item $TempConfig -Force -Confirm:$false
    $APIKeys = Get-Credential -Message 'Enter your Manage public and private API keys'
    $Config.CWMConnectionInfo | Add-Member -NotePropertyName credential -NotePropertyValue $APIKeys
    $Config | Export-Clixml -Path $Path
}

$ConfigTemplate = @{
    CWMConnectionInfo = @{
        Server = 'example.domain.com'
        Company = 'ACME'
        ClientID = 'GenerateAKey'
    }
    ScheduledStart = '09:00'
    ScheduledEnd = '17:00'
    ManageUser = 'ctaylor'
    TimeFrame = 60
    LunchStart = ''
    LunchEnd = ''
    AutoClose = $true
    TimeWrapChargeCode = 'Undocumented'
    TaskName = 'ManageTimeReminder'
}

#Check for config
if (!(Test-Path $ConfigPath)){
    Write-TSLog 'Config not found.'
    Save-Config -Template $ConfigTemplate -Path $ConfigPath
}
#Load config
Write-TSLog 'Loading config.'
try {
    $Config = Import-Clixml -Path $ConfigPath
} catch {
    Write-TSLog -Level Error 'There was an error loading the config. Was this config created on a different machine or for a different user?'
    Write-TSLog -Level Error "Please remove the config file and try again. $ConfigPath"
    exit 1
}

#Validate config
if (!$Config.CWMConnectionInfo) {
    Write-TSLog 'Requesting Manage connection information.'
    $Config | Add-Member -NotePropertyName CWMConnectionInfo -NotePropertyValue $ConfigTemplate.CWMConnectionInfo
    Save-Config -Template $Config -Path $ConfigPath
    $Config = Import-Clixml -Path $ConfigPath
}

try {
    $CWMConnectionInfo = @{
        Server = $Config.CWMConnectionInfo.Server
        Company = $Config.CWMConnectionInfo.Company
        pubkey = $Config.CWMConnectionInfo.credential.UserName
        privatekey = $Config.CWMConnectionInfo.credential.GetNetworkCredential().Password
        ClientID = $Config.CWMConnectionInfo.ClientID
    }
    Connect-CWM @CWMConnectionInfo -ErrorAction Stop
} catch {
    Disconnect-CWM
    $Config.PSObject.Properties.Remove('CWMConnectionInfo')
    $Config | Export-Clixml -Path $ConfigPath -Force
    Write-TSLog -Level Error 'Manage Connection information is incorrect.'
    Write-TSLog -Level Error 'Clearing connection info, run again to re-enter.'
    exit 1
}

#if $Config.TimeFrame set make sure there is a scheduled task.
if($Config.TimeFrame){
    #Install: the scheduled task runs the local copy. Running a newly downloaded copy replaces it.
    if($PSCommandPath -and $PSCommandPath -ne $ScriptPath){
        Write-TSLog "Copying $PSCommandPath to $ScriptPath."
        Copy-Item -LiteralPath $PSCommandPath -Destination $ScriptPath -Force
    }
    if(-not (Test-Path $ScriptPath)){
        Write-TSLog -Level Error "$ScriptPath is missing. The scheduled task will not be created."
        exit 1
    }

    #Setup scheduled task, or replace one from an older version (launched through SilentLaunchPoSh.vbs, elevated)
    $TaskQuery = Get-ScheduledTask -TaskName $Config.TaskName -ErrorAction SilentlyContinue
    if(!$TaskQuery -or $TaskQuery.Actions[0].Execute -ne 'conhost.exe'){
        Write-TSLog "Creating scheduled task, $($Config.TaskName)."
        $Shift = New-TimeSpan $Config.ScheduledStart $Config.ScheduledEnd
        $Duration = '{0:D2}:{1:D2}' -f [int][math]::Floor($Shift.TotalHours), $Shift.Minutes
        $ScheduledTask = schtasks /Create /RU $env:USERNAME /SC WEEKLY /D MON,TUE,WED,THU,FRI /ST $Config.ScheduledStart /DU $Duration /TN $Config.TaskName /RL LIMITED /RI 5 /F /TR "hostname" 2>&1
        #conhost --headless keeps the console hidden; only the time entry window is shown.
        $Action = New-ScheduledTaskAction -Execute 'conhost.exe' -Argument "--headless powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$ScriptPath`""
        $null = Set-ScheduledTask -TaskName $Config.TaskName -Action $Action -User $env:USERNAME
        Write-TSLog ($ScheduledTask -join ' ')
        Remove-Item (Join-Path $ScriptDir 'SilentLaunchPoSh.vbs') -Force -ErrorAction SilentlyContinue
    }
}
else{
    $null = SCHTASKS /Delete /TN $Config.TaskName /F 2>&1
}

Write-TSLog 'Starting time frame check.'
#Get latest time entries
$condition = "enteredBy='$($Config.ManageUser)'"
$LatestTimeEntry = Get-CWMTimeEntry -Condition $condition -orderBy 'timeEnd desc' -pageSize 1 -fields 'timeEnd'
[datetime]$LastTimeEntry = $LatestTimeEntry.timeEnd

#If no time entry today set to $($Config.ScheduledStart)
if($LastTimeEntry -lt (Get-Date).Date){
    [datetime]$LastTimeEntry = Get-Date $($Config.ScheduledStart)
}

#Lunch break, no prompt during lunch and don't count it against $Config.TimeFrame
$LunchCheck = Get-LunchAdjustedTime -LastTimeEntry $LastTimeEntry -LunchStart $Config.LunchStart -LunchEnd $Config.LunchEnd
if($LunchCheck.InLunch){
    Write-TSLog 'Lunch break, skipping time frame check.'
    exit
}
[datetime]$LastTimeEntry = $LunchCheck.LastTimeEntry

#If last time entry was more than $Config.TimeFrame minutes old prompt for time input.
if($LastTimeEntry -gt (Get-Date).AddMinutes((($Config.TimeFrame * -1) -2))){
    #Last time entry was within $Config.TimeFrame
    Write-TSLog "Last time entry was $LastTimeEntry."
    exit
}

#Get CW icon if on machine
$CWIconFile = Get-ChildItem "C:\Program Files*\ConnectWise\PSA.net\ConnectWise.ico" -ErrorAction SilentlyContinue | Select-Object -First 1
if($CWIconFile){
    $CWIcon = " Icon='$($CWIconFile.FullName)'"
}

Write-TSLog 'Loading XAML'
$inputXAML = @"
<Window x:Class="WpfApplication6.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApplication6"
        mc:Ignorable="d"
        Title="$ScriptName" Height="425" Width="600" Topmost="True"$CWIcon>
    <Grid>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="235*"/>
            <ColumnDefinition Width="15*"/>
            <ColumnDefinition Width="343*"/>
        </Grid.ColumnDefinitions>
        <TextBox x:Name="textBox" Margin="10,72,9.333,43" TextWrapping="Wrap" Grid.ColumnSpan="3" AcceptsReturn="True" SpellCheck.IsEnabled="True"/>
        <Label x:Name="StartLabel" Content="Start Time" Height="30" Margin="0,10,156.333,0" VerticalAlignment="Top" RenderTransformOrigin="0.497,-0.795" FontSize="11" Grid.Column="2" HorizontalAlignment="Right" Width="60"/>
        <TextBox x:Name="EndTime" HorizontalAlignment="Right" Height="22" Margin="0,10,73.333,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="78" Grid.Column="2"/>
        <TextBox x:Name="StartTime" Height="22" Margin="0,10,220.333,0" TextWrapping="Wrap" VerticalAlignment="Top" Grid.Column="2" HorizontalAlignment="Right" Width="79"/>
        <Label x:Name="EndLabel" Content="End Time" HorizontalAlignment="Right" Height="30" Margin="0,10,9.333,0" VerticalAlignment="Top" Width="59" RenderTransformOrigin="0.497,-0.795" FontSize="11" Grid.Column="2"/>
        <ComboBox x:Name="comboBox" Height="22" Margin="10,11,82.333,0" VerticalAlignment="Top" IsEnabled="True"/>
        <Button x:Name="Submit" Content="Submit" Margin="0,0,9.333,9" Grid.Column="2" HorizontalAlignment="Right" Width="75" Height="30" VerticalAlignment="Bottom"/>
        <TextBlock x:Name="Status" Margin="10,0,0.333,9" TextWrapping="Wrap" Height="20" VerticalAlignment="Bottom"/>
        <Label x:Name="RecentLabel" Content="Recent" Height="30" Margin="0,37,250.333,0" VerticalAlignment="Top" RenderTransformOrigin="0.497,-0.795" FontSize="11" HorizontalAlignment="Right" Width="43" Grid.Column="2"/>
        <ComboBox x:Name="comboBoxTicket" Grid.ColumnSpan="3" Margin="10,41,298.333,0" Height="21" VerticalAlignment="Top" IsEnabled="True"/>
        <Label x:Name="ChargeCodeLabel" Content="Charge Code" Height="30" Margin="0,11,0.333,0" VerticalAlignment="Top" RenderTransformOrigin="0.497,-0.795" FontSize="11" HorizontalAlignment="Right" Width="74"/>
        <TextBlock x:Name="todaysHours" Grid.Column="2" HorizontalAlignment="Right" Height="19" Margin="0,0,89.333,13" TextWrapping="Wrap" Text="14.05 Hours Today" VerticalAlignment="Bottom" Width="101"/>
        <TextBox x:Name="TicketNumber" Height="22" Margin="0,40,73.333,0" TextWrapping="Wrap" VerticalAlignment="Top" Grid.Column="2" HorizontalAlignment="Right" Width="79"/>
        <Label x:Name="TicketLabel" Content="Ticket #" Height="30" Margin="0,37,10.333,0" VerticalAlignment="Top" RenderTransformOrigin="0.497,-0.795" FontSize="11" Grid.Column="2" HorizontalAlignment="Right" Width="60"/>
        <CheckBox x:Name="TimeWrap" Content="TimeWrap" Grid.Column="2" HorizontalAlignment="Right" Margin="0,43,170.333,0" VerticalAlignment="Top"/>
    </Grid>
</Window>
"@

#region -[Don't mess with this region]-

$inputXAML = $inputXAML -replace 'mc:Ignorable="d"','' -replace "x:N",'N' -replace '^<Win.*', '<Window'
Add-Type -AssemblyName PresentationFramework
[xml]$XML = $inputXAML

#Read converted XAML
$reader=(New-Object System.Xml.XmlNodeReader $XML)
try{
    $Form=[Windows.Markup.XamlReader]::Load( $reader )
}
catch [System.Management.Automation.MethodInvocationException] {
    Write-Warning 'Issue with XAML.  Check the syntax for this control...'
    Write-Error $error[0].Exception.Message
    if ($error[0].Exception.Message -like "*button*"){
        Write-Warning 'Ensure your button in the $inputXAML does NOT have a `Click=ButtonClick` property.'
    }
}
catch{
    Write-Output 'Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure .net is installed.'
}

#Store form nodes as PowerShell variables and append with WPF
$XML.SelectNodes("//*[@Name]") | ForEach-Object{Set-Variable -Name "WPF$($_.Name)" -Value $Form.FindName($_.Name)}

#endregion

#region -[Execution]-

#Start and stop times
$WPFStartTime.Text = $LastTimeEntry.ToString("t")
$WPFEndTime.Text = (Get-Date).ToString("t")

#Populate Charge Codes
Write-TSLog 'Loading Charge Codes'
$ChargeCodes = Get-CWMChargeCode
$ChargeCodes.Description | ForEach-Object { $null = $WPFcomboBox.Items.add($_) }

#Populate service tickets
#TODO limit to open tickets with time entry in last two days
Write-TSLog 'Loading Recent tickets'
$TimeEntryCondition = "enteredBy = '$($Config.ManageUser)' and chargeToType = 'ServiceTicket' and dateEntered > $((Get-Date).AddDays(-2) | ConvertTo-CWMTime)"
$LatestTimeEntries = Get-CWMTimeEntry -Condition $TimeEntryCondition -orderBy 'timeEnd desc' -fields @('chargeToId','timeStart') -all
$RecentTimeEntryTicketIDs = $LatestTimeEntries.chargeToId | Sort-Object -Unique
if ($RecentTimeEntryTicketIDs) {
    $RecentTicketCondition = "id in ($($RecentTimeEntryTicketIDs -join ',')) and closedFlag = false"
    $RecentTickets = Get-CWMTicket -condition $RecentTicketCondition -fields @('id','company','summary')
    foreach($Ticket in $RecentTickets){
        $CompanyTrimmed = $Ticket.company.identifier.Substring(0, [System.Math]::Min(15, $Ticket.company.identifier.Length))
        $null = $WPFcomboBoxTicket.Items.add("$($Ticket.id):$CompanyTrimmed\$($Ticket.summary)")
    }
}

#Todays total hours
$TimeEntryCondition = "enteredBy = '$($Config.ManageUser)' and  dateEntered > $(Get-Date 00:00 | ConvertTo-CWMTime)"
$TodaysTimeEntries = Get-CWMTimeEntry -Condition $TimeEntryCondition -orderBy 'timeEnd desc' -fields @('actualHours') -all
$TodaysTotal = (($TodaysTimeEntries.actualHours) | Measure-Object -Sum).Sum
$WPFtodaysHours.text = "$TodaysTotal hours today"

Write-TSLog 'Loading form elements'

$WPFStatus.Text = $Quotes | Get-Random

#Verify only one option is selected
$WPFcomboBox.add_DropDownClosed({
    if($WPFcomboBox.Text){
        $WPFcomboBoxTicket.Text = ''
        $WPFTicketNumber.Text = ''
        $WPFTimeWrap.IsChecked = $false
        $WPFStartTime.Text = $LastTimeEntry.ToString("t")
        $WPFEndTime.Text = (Get-Date).ToString("t")
    }
})
$WPFcomboBoxTicket.add_DropDownClosed({
    if($WPFcomboBoxTicket.Text){
        $WPFcomboBox.Text = ''
        $WPFTicketNumber.Text = ''
        $WPFTimeWrap.IsChecked = $false
        $WPFStartTime.Text = $LastTimeEntry.ToString("t")
        $WPFEndTime.Text = (Get-Date).ToString("t")
    }
})
$WPFTicketNumber.add_LostFocus({
    if($WPFTicketNumber.Text){
        $WPFcomboBox.Text = ''
        $WPFcomboBoxTicket.Text = ''
        $WPFTimeWrap.IsChecked = $false
        $WPFStartTime.Text = $LastTimeEntry.ToString("t")
        $WPFEndTime.Text = (Get-Date).ToString("t")
    }
})
$WPFTimeWrap.add_Click({
    if($WPFTimeWrap.IsChecked){
        $WPFTicketNumber.Text = ''
        $WPFcomboBox.Text = ''
        $WPFcomboBoxTicket.Text = ''
        $WPFStartTime.Text = (Get-Date $($Config.ScheduledStart)).ToString("t")
        $WPFEndTime.Text = (Get-Date $($Config.ScheduledEnd)).ToString("t")
    }
})

#Submit
$WPFSubmit.add_click({
    $Valid = $true
    if(!(Test-Time $WPFStartTime.Text)){
        $Valid = $false
        $WPFStatus.Text = 'Start Time is incorrect.'
    }
    if(!(Test-Time $WPFEndTime.Text)){
        $Valid = $false
        $WPFStatus.Text = 'End Time is incorrect.'
    }
    if(!$WPFcomboBox.Text -and !$WPFcomboBoxTicket.Text -and !$WPFTimeWrap.IsChecked){
        $Valid = $false
        $WPFStatus.Text = 'Choose a charge code, service ticket or TimeWrap.'
    }
    if($WPFtextBox.Text.length -lt 20){
        $Valid = $false
        $WPFStatus.Text = 'Enter better notes.'
    }

    if($Valid){
        $TimeEntryParams = @{
            notes = $WPFtextBox.Text
            timeStart = Get-Date $WPFStartTime.Text | ConvertTo-CWMTime -Raw
            timeEnd = Get-Date $WPFEndTime.Text | ConvertTo-CWMTime -Raw
        }
        if($WPFcomboBoxTicket.Text){
            #Recent Ticket
            $TimeEntryParams.chargeToId = $WPFcomboBoxTicket.Text.Split(':')[0]
            $TimeEntryParams.chargeToType = 'ServiceTicket'
        }
        else{
            #Time Wrap or Charge Code
            $ChargeCodeName = if($WPFTimeWrap.IsChecked){ $Config.TimeWrapChargeCode } else{ $WPFcomboBox.Text }
            $TimeEntryParams.chargeToId = ($ChargeCodes | Where-Object{ $_.Description -eq $ChargeCodeName }).'TE_Charge_Code_RecID'
            $TimeEntryParams.chargeToType = 'ChargeCode'
            $TimeEntryParams.billableOption = 'NoCharge'
            if($WPFTimeWrap.IsChecked){ $TimeEntryParams.hoursDeduct = $TodaysTotal }
        }
        try {
            $null = New-CWMTimeEntry @TimeEntryParams -ErrorAction Stop
            if($Config.AutoClose){ $Form.Close() }
            $WPFStatus.Text = 'Time entry successfully created.'
            $WPFStartTime.Text = Get-Date -Format t
            $WPFEndTime.Text = ''
            $WPFtextBox.Text = ''
            $WPFcomboBox.Text = ''
        } catch {
            $WPFStatus.Text = 'There was an error creating the time entry.'
            Write-TSLog -Level Error "There was an error creating the time entry. $_"
            $wshell = New-Object -ComObject Wscript.Shell
            $null = $wshell.Popup($_,0,"Error creating Time Entry",0x1010)
        }
    }
})

#endregion

#Shows the form
Write-TSLog 'Launching form.'
$null = $Form.ShowDialog()

Write-TSLog 'Done.'
