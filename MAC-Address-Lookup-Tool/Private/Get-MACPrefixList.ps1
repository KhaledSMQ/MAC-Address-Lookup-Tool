Function Get-MACPrefixList {

    <#
    
        .SYNOPSIS
        Returns the raw MAC prefix list

        .DESCRIPTION
        Returns the raw MAC prefix list. If the file does not exists, its runs 'Download-MACPrefixList'
        to download it, then return the contents. If the file is older than a week, it will also 
        download a new copy.

        .PARAMETER DownloadNewCopy
        Forces a download of the MAC prefix list regardless if it is stale
    
    #>

    [CmdletBinding()]
    Param (
        [Parameter(Position=0)]
        [Switch]$DownloadNewCopy
    )

    $InformationPreference = "Continue"
    $PrefixListPath = "$PSScriptRoot\..\Resources\List.txt"

    #Check if a copy of the file already exists
    $File = Get-ChildItem $PrefixListPath -ErrorAction SilentlyContinue
    $TestPath = $File | Test-Path
    $OneWeekAgo = (Get-Date).AddDays(-7)

    If ($TestPath -eq $False -or $File.LastWriteTime -lt $OneWeekAgo -or $DownloadNewCopy) {

        Write-Information "Downloading a fresh copy of the prefix list..."

        Download-MACPrefixList

    }
    
    Else {

        Write-Verbose "Utilizing the existing copy of the prefix list"

    }

    $PrefixList = Get-Content $PrefixListPath

    Write-Output $PrefixList

}