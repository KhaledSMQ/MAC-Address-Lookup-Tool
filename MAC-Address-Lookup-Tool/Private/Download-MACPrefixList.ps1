Function Download-MACPrefixList {

    <#
    
        .SYNOPSIS
        Downloads a copy of the MAC prefix list

        .DESCRIPTION
        Downloads a copy of the MAC prefix list from linuxnet.ca into a text file in the 
        resources folder in the module root.

        .PARAMETER DownloadURL
        The URL to the MAC prefix list. Has a default value

        .PARAMETER OutputFileName
        The name of the file that will store the downloaded MAC prefix list

    #>

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