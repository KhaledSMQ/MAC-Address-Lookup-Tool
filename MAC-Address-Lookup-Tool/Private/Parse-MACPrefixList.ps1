Function Parse-MACPrefixList {

    <#
    
        .SYNOPSIS
        Parses the raw output of the MAC prefix list

        .DESCRIPTION
        Takes the output from 'Get-MACPrefixList' and returns parsed data in form of an object
        with two properties, 'MACPrefix' and 'MACVendor'. 
    
    #>
    
    [CmdletBinding()]

    $List = Get-MACPrefixList

    Write-Output $List | ForEach { [PSCustomObject]@{"MACPrefix"=$_.Substring(0,6); "MACVendor"=$_.SubString(7)} }

}