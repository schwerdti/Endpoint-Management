#=============================================================================================================================
#
# Script Name:         Prioritize_WiFiNetworkProfile_Detect.ps1
# Description:         Check if desired wireless network profile is first
# Changelog:           2024-07-10: Inital version.
# Author:              Steffen Schwerdtfeger, glueckkanja.com
#
#=============================================================================================================================

# define Variables
$wifiProfileName = "eduroam"

# Get all wireless network profiles
$wifiProfiles = ((netsh wlan show profiles) -match '\s{2,}:\s') -replace '.*:\s' , ''

# Check if desired profile is first
if($wifiProfiles[0] -eq $wifiProfileName) {
    Write-Output "Network $wifiProfileName is the first in the list. OK."
    exit 0
} else {
    $index = [array]::IndexOf($wifiProfiles, $wifiProfileName)
    if($index -eq -1) {
        Write-Output "Network $wifiProfileName not found on the client."
    } else {
        Write-Output "Network $wifiProfileName is NOT the first in the list. Current index: $index."
    }
    exit 1
}