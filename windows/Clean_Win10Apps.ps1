Set-StrictMode -Version 2.0
<#
# Updated for 1903
# - Added holographic first run, may have caused weird start menu bug without it
# - change to 3d viewer application name
# - added game bar removal
#>

$sw = [System.Diagnostics.Stopwatch]::StartNew()
$firstAffectedVersion = [System.Management.Automation.SemanticVersion]("7.1.0")
$lastAffectedVersion  = [System.Management.Automation.SemanticVersion]("999.0.0")

if (
  ($PSVersionTable.PSVersion -ge $firstAffectedVersion) -and 
  ($PSVersionTable.PSVersion -le $lastAffectedVersion )
)
#Import-Module -SkipEditionCheck
{  Import-Module -Name Appx -UseWindowsPowerShell  }

$InstalledApps = Get-AppxPackage -AllUsers | Select-Object Name

$AppList = @(

    #Unnecessary Windows 10 AppX Apps
    "Microsoft.3DBuilder"
    "Microsoft.MixedReality.Portal",
    "Microsoft.BingNews"
    "*Microsoft.BingWeather*"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.Messaging"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.NetworkSpeedTest"
    "Microsoft.News"
    "Microsoft.Office.Lens"
    #"Microsoft.Office.OneNote"
    "Microsoft.Office.Sway"
    "Microsoft.OneConnect"
    "Microsoft.People"
    "Microsoft.Print3D"
    "Microsoft.Paint3D"
    #"Microsoft.RemoteDesktop"
    "Microsoft.SkypeApp"
    "Microsoft.StorePurchaseApp"
    "Microsoft.Office.Todo.List"
    "Microsoft.Whiteboard"
    #"Microsoft.WindowsAlarms"
    #"Microsoft.WindowsCamera"
    #"microsoft.windowscommunicationsapps"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    #"Microsoft.WindowsSoundRecorder"
    "Microsoft.Wallet"
    # "Microsoft.Xbox.TCUI"
    # "Microsoft.XboxApp"
    # "Microsoft.XboxGameOverlay"
    # "Microsoft.XboxGamingOverlay"
    # "Microsoft.XboxIdentityProvider"
    # "Microsoft.XboxSpeechToTextOverlay"
    # "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "Microsoft.YourPhone"

    #Sponsored Windows 10 AppX Apps
    #Add sponsored/featured apps to remove in the "*AppName*" format
    "*EclipseManager*"
    "*ActiproSoftwareLLC*"
    "*Duolingo*"
    "*CandyCrush*"
    "*BubbleWitch3Saga*"
    "*Wunderlist*"
    "*Flipboard*"
    "*Twitter*"
    "*Facebook*"
    "*Spotify*"
    "*Minecraft*"
    "*Royal Revolt*"
    "*Sway*"
    "*Speed Test*"
    "*Dolby*"
    "*Pandora*"
    "*Adobe*"
    "*News*"
    "*Disney*"
    "Microsoft.MinecraftUWP"
    "ShazamEntertainmentLtd.Shazam"    
    "ClearChannelRadioDigital.iHeartRadio"
)

function Write-LogEntry {
    param(
        [parameter(Mandatory = $true, HelpMessage = "Value added to the RemovedApps.log file.")]
        [ValidateNotNullOrEmpty()]
        [string]$Value,

        [parameter(Mandatory = $false, HelpMessage = "Name of the log file that the entry will written to.")]
        [ValidateNotNullOrEmpty()]
        [string]$FileName = "RemovedApps.log"
    )
    # Determine log file location
    #$LogFilePath = Join-Path -Path PWS -ChildPath "$($FileName)"

    # Add value to log file
    try {
        Out-File -InputObject $Value -Append -NoClobber -Encoding Default -FilePath $FileName -ErrorAction Stop
    }
    catch [System.Exception] {
        Write-Warning -Message "Unable to append log entry to $($FileName) file"
    }
}

function Remove3dObjects {
    #Removes 3D Objects from the 'My Computer' submenu in explorer
    Write-LogEntry "Removing 3D Objects from explorer 'My Computer' submenu"
    $Objects32 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
    $Objects64 = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
    If (Test-Path $Objects32) {
        Remove-Item $Objects32 -Recurse 
    }
    If (Test-Path $Objects64) {
        Remove-Item $Objects64 -Recurse 
    }
}

foreach ($appfound in $InstalledApps) {
    Write-LogEntry -Value "$($appfound.Name) was found in Installed Apps" #-ForegroundColor Yellow

    foreach ($possibleapp in $AppList) {
        if ($appfound.Name -like $possibleapp) {
            Write-LogEntry -Value "`t$($appfound.Name) matched $possibleapp" #-ForegroundColor green
            
            $appholder = Get-AppxPackage -Name $possibleapp -AllUsers 
            try {
                Remove-AppxPackage $appholder -ErrorAction SilentlyContinue
                Write-LogEntry -Value "`t$appholder was removed" #-ForegroundColor DarkGreen
            }
            catch {
                Write-LogEntry -Value "`t$appholder couldn't be removed" #-ForegroundColor Red 
            }
            
            $appholder2 = Get-AppXProvisionedPackage -Online | Where-Object DisplayName -EQ $possibleapp
            if ($null -ne $appholder2) {
                try {
                    Remove-AppxProvisionedPackage $appholder2 -Online
                    Write-LogEntry -Value "`t$($appholder2.DisplayName) was removed" #-ForegroundColor DarkGreen
                }
                catch {                    
                    Write-LogEntry -Value "`tUnable to remove the online app $($appholder2.DisplayName)" #-ForegroundColor DarkMagenta
                }
            }
        }
    }
}

Remove3dObjects

$sw.Stop()
Write-LogEntry "Script has finished in $($sw.Elapsed.ToString())"