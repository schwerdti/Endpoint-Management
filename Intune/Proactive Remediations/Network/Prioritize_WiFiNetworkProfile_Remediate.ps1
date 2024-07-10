#=============================================================================================================================
#
# Script Name:         Prioritize_WiFiNetworkProfile_Remediate.ps1
# Description:         Change priority of desired wireless network profile
#                      on all interfaces to 1.
# Changelog:           2024-07-10: Inital version.
# Author:              Steffen Schwerdtfeger, glueckkanja.com
#
#=============================================================================================================================

# define Variables
$wifiProfileName = "eduroam"

try {

    Write-Output "Search for all wireless network adapters."
    # Run the 'netsh wlan show interface' command and capture the output
    $adapterInfo = netsh wlan show interface

    # Initialize an empty array to store adapter names
    $adapters = @()

    # Split the output by lines
    $lines = $adapterInfo -split "`n"

    # Iterate over each line
    foreach ($line in $lines) {
        # Check if the line contains "Name" (indicating an adapter name)
        if ($line -match "Name") {
            # Extract the adapter name and add it to the list
            $adapterName = $line -replace "Name\s*:\s*", ""
            $adapterName = $adapterName.Trim()
            $adapters += $adapterName
        }
    }

    # Print the list of available wireless network adapters
    Write-Output "Found the following wireless network adapters:"
    foreach ($adapter in $adapters) {
        Write-Output "- $adapter"
    }

    Write-Output "---------------------------------------------------------------------------"

    # Set priority for each network adapter
    foreach ($adapter in $adapters) {
        Write-Output "Set priority=1 for network $wifiProfileName on interface $adapter."
        netsh wlan set profileorder name="$wifiProfileName" interface="$adapter" priority=1
    }

    exit 0

} catch {
    # error occured
    $errMsg = $_.Exception.Message
    Write-Output "Error: $errMsg"
    exit 1
}