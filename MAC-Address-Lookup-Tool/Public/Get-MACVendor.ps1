Function Get-MACVendor {

    <#
    
        .SYNOPSIS
        Returns the vendor of a given MAC address, or returns the MAC prefix(s) for a given vendor

        .DESCRIPTION
        Takes an inputted MAC address, or MAC address prefix in a variety of different formats and returns
        the assined vendor of the MAC address based on the OUI list published by the IEEE. It can also take
        an inputted MAC address vendor, and return all of its assigned MAC address prefixes.

        .PARAMETER MAC
        The MAC(s) or MAC prefix(s) you wish to get the vendor name for. Accepts various different formats:
         - 123ABC
         - 123456ABCDEF
         - 12.3A.BC
         - 12.34.56.AB.DC.EF
         - 12-3A-BC
         - 12-34-56-AB-CD-EF
         - 1234-56AB-CDEF
         - 1234.56AB.CDEF

        .PARAMETER Vendor
        The name of the vendor you wish to recieve assined MAC prefixes for.

        .EXAMPLE
        PS> Get-MACVendor -MAC '0007B3','DC86D8','001377','94EB2C','B84FD5'
        MACPrefix MACVendor
        --------- ---------
        0007B3    Cisco
        DC86D8    Apple
        001377    Samsung
        94EB2C    Google
        B84FD5    Microsoft

        .EXAMPLE
        PS> '0007B3','DC86D8','001377','94EB2C','B84FD5' | Get-MACVendor
        MACPrefix MACVendor
        --------- ---------
        0007B3    Cisco
        DC86D8    Apple
        001377    Samsung
        94EB2C    Google
        B84FD5    Microsoft

        .EXAMPLE
        PS> Get-MACVendor -Vendor 'OnePlus'
        MACPrefix MACVendor
        --------- ---------
        94652D    OnePlus
        C0EEFB    OnePlus
        64A2F9    OnePlus
    
    #>

    [CmdletBinding()]
    Param (

        [Parameter(Position=0,Mandatory=$True,ParameterSetName='LookupByMAC',ValueFromPipeline=$True)]
        [String[]]$MAC,

        [Parameter(Position=0,Mandatory=$True,ParameterSetName='LookupByVendor')]
        [String]$Vendor

    )

    Begin {

        $MACList = Parse-MACPrefixList

    }

    Process {
    
        Switch ($PSCmdlet.ParameterSetName) {

            'LookupByMAC' {

                ForEach ($Address in $MAC) {

                    Switch -Regex ($Address) {

                        #Matches 123ABC format
                        '[A-Fa-f0-9]{6}' {
                
                            #Nothing needs to be done, already in the correct format for where-object
                
                        }
                
                        #Matches 123456ABCDEF format
                        '[A-Fa-f0-9]{12}' {
                
                            $Address = $Address.Substring(0,6)
                
                        }
                        
                        #Matches 12.3A.BC format
                        '[A-Fa-f0-9]{2}\.[A-Fa-f0-9]{2}\.[A-Fa-f0-9]{2}' {
                
                            $Address = $Address.Replace(".","").Substring(0,6)
                
                        }
                
                        #Matches 12.34.56.AB.DC.EF format
                        '[A-Fa-f0-9]{2}\.[A-Fa-f0-9]{2}\.[A-Fa-f0-9]{2}\.[A-Fa-f0-9]{2}\.[A-Fa-f0-9]{2}\.[A-Fa-f0-9]{2}' {
                
                            $Address = $Address.Replace(".","").Substring(0,6)
                
                        }
                
                        #Matches 12-3A-BC
                        '[A-Fa-f0-9]{2}\-[A-Fa-f0-9]{2}\-[A-Fa-f0-9]{2}' {
                
                            $Address = $Address.Replace("-","")
                
                        }
                
                        #Matches 12-34-56-AB-CD-EF
                        '[A-Fa-f0-9]{2}\-[A-Fa-f0-9]{2}\-[A-Fa-f0-9]{2}\-[A-Fa-f0-9]{2}\-[A-Fa-f0-9]{2}\-[A-Fa-f0-9]{2}' {
                            
                            $Address = $Address.Replace("-","").Substring(0,6)
                
                        }
                
                        #Matches 1234-56AB-CDEF
                        '[A-Fa-f0-9]{4}\-[A-Fa-f0-9]{4}\-[A-Fa-f0-9]{4}' {
                
                            $Address = $Address.Replace("-","").Substring(0,6)
                
                        }
                
                        #Matches 1234.56AB.CDEF
                        '[A-Fa-f0-9]{4}\.[A-Fa-f0-9]{4}\.[A-Fa-f0-9]{4}' {
                
                            $Address = $Address.Replace(".","").Substring(0,6)
                
                        }
                
                    }
                
                    $Output = ($MACList | Where-Object { $_.MACPrefix -eq $Address })

                    Write-Output $Output

                }
                
            }

            'LookupByVendor' {

                $Output = $MACList | Where-Object { $_.MACVendor -eq $Vendor }

                Write-Output $Output
                
            }

        }

    }

    End {

    }
    
}