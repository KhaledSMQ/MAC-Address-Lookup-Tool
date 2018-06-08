Function Parse-MACPrefixList {

    <#
    
        .SYNOPSIS
        Parses the raw output of the MAC prefix list

        .DESCRIPTION
        Takes the output from 'Get-MACPrefixList' and returns parsed data in form of an object
        with two properties, 'MACPrefix' and 'MACVendor'. 
    
    #>
    
    [CmdletBinding()]

    #Gather the list from the cache, or if not found it will be downloaded automatically.
    $List = Get-MACPrefixList

    #Parse each line of the file, create an object with two properties, and populate the properties.
    Write-Output $List | ForEach { [PSCustomObject]@{"MACPrefix"=$_.Substring(0,6); "MACVendor"=$_.SubString(7)} }

}