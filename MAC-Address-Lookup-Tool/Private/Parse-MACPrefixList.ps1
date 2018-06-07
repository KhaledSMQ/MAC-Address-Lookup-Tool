Function Parse-MACPrefixList {

    [CmdletBinding()]

    $List = Get-MACPrefixList

    Write-Output $List | ForEach { [PSCustomObject]@{"MACPrefix"=$_.Substring(0,6); "MACVendor"=$_.SubString(7)} }

}