Function Download-MACPrefixList {

    [CmdletBinding()]
    Param (
        [Parameter(Position=0)]
        $DownloadURL = 'https://linuxnet.ca/ieee/oui/nmap-mac-prefixes',
        $OutputFileName = 'List.txt'
    )

    $Response = ((Invoke-WebRequest -Uri $DownloadURL).Content -split "`n")

    $Response = $Response[0..($Response.Length-2)]

    $Response | Out-File $PSScriptRoot\..\Resources\$OutputFileName

}