If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Write-Host "You didn't run this script as an Administrator. This script will self elevate to run as an Administrator and continue."
    Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit
}

$path = Get-Location
If ((Test-Path "${env:USERPROFILE}\Documents\WindowsPowerShell") -eq $False) {
    New-Item -Path "${env:USERPROFILE}\Documents\WindowsPowerShell" -ItemType Directory
    Write-Output "The folder WindowsPowerShell was successfully created."
}
If ((Test-Path "${env:USERPROFILE}\Documents\PowerShell") -eq $False) {
    New-Item -Path "${env:USERPROFILE}\Documents\PowerShell" -ItemType Directory
    Write-Output "The folder PowerShell was successfully created."
}

New-Item -ItemType SymbolicLink -Path "${env:USERPROFILE}\Documents\WindowsPowerShell\profile.ps1" -Target "${path}/profile.ps1"    
New-Item -ItemType SymbolicLink -Path "${env:USERPROFILE}\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Target "${path}/profile.ps1"
New-Item -ItemType SymbolicLink -Path "${env:USERPROFILE}\Documents\PowerShell\profile.ps1" -Target "${path}/profile.ps1"    
New-Item -ItemType SymbolicLink -Path "${env:USERPROFILE}\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Target "${path}/profile.ps1"

Write-Output "Set PowerShell profile finish."
