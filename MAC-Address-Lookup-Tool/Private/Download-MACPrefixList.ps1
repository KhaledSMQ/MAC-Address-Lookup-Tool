Function Download-MACPrefixList {

    [CmdletBinding()]
    Param (
        [Parameter(Position=0)]
        $DownloadURL = 'https://linuxnet.ca/ieee/oui/nmap-mac-prefixes'
    )

    $Response = (Invoke-WebRequest -Uri $DownloadURL).Content

    $Response | Out-File $PSScriptRoot\..\Resources\List.txt

}