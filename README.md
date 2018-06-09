<a href="https://ci.appveyor.com/project/MaxAnderson95/MAC-Address-Lookup-Tool">
<img src="https://ci.appveyor.com/api/projects/status/github/MaxAnderson95/MAC-Address-Lookup-Tool?branch=master&svg=true" alt="Project Badge" width="125">
</a>

# MAC-Address-Lookup-Tool
A PowerShell module that will output the vendor name for a given MAC address or MAC address prefix. It will also take the vendor name as an input and output all of its assigned MAC address prefixes.

## Installation
Via the PowerShell Gallery on PowerShell 5/0 and up (Recommended):
```Powershell
PS> Install-Module MAC-Address-Lookup-Tool
```

Via Git:
1. Change directory into one of your $env:psmodulepath directories.
2. Run the following:
```Powershell
PS> git clone https://github.com/MaxAnderson95/MAC-Address-Lookup-Tool
```

Manually:
1. Download a zip'd copy of the repo https://github.com/MaxAnderson95/MAC-Address-Lookup-Tool
2. Unzip the repo into one of your $env:psmodulepath directories.

## Usage
```PowerShell
PS> Get-MACVendor -MAC '0007B3','DC86D8','001377','94EB2C','B84FD5'

MACPrefix MACVendor
--------- ---------
0007B3    Cisco
DC86D8    Apple
001377    Samsung
94EB2C    Google
B84FD5    Microsoft
```
```PowerShell
PS> '0007B3','DC86D8','001377','94EB2C','B84FD5' | Get-MACVendor

MACPrefix MACVendor
--------- ---------
0007B3    Cisco
DC86D8    Apple
001377    Samsung
94EB2C    Google
B84FD5    Microsoft
```
```PowerShell
PS> Get-MACVendor -Vendor 'OnePlus'

MACPrefix MACVendor
--------- ---------
94652D    OnePlus
C0EEFB    OnePlus
64A2F9    OnePlus
```