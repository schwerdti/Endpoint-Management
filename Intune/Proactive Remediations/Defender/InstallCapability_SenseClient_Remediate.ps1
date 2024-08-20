#=============================================================================================================================
#
# Script Name:         InstallCapability_SenseClient_Remediate.ps1
# Description:         Install capability Microsoft.Windows.Sense.Client
# Changelog:           2024-08-20: Inital version.
# Author:              Steffen Schwerdtfeger, glueckkanja.com
#
#=============================================================================================================================

# Add Microsoft.Windows.Sense.Client
try {

    Add-WindowsCapability -Name "Microsoft.Windows.Sense.Client~~~~" -Online
    Write-Output "Added WindowsCapability Microsoft.Windows.Sense.Client. Reboot required."
    exit 0

} catch {
    # error occured
    $errMsg = $_.Exception.Message
    Write-Output "Error: $errMsg"
    exit 1
}