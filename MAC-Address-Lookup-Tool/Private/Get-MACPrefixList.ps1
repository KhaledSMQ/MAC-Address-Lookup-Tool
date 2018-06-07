Function Get-MACPrefixList {

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