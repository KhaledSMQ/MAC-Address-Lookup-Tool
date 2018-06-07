Function Get-MACVendor {

    [CmdletBinding()]
    Param (

        [String]$MAC

    )

    $MACList = Parse-MACPrefixList

    Switch -Regex ($MAC) {

        #Matches 123ABC format
        '[A-Fa-f0-9]{6}' {

            #Nothing needs to be done, already in the correct format for where-object

        }

        #Matches 123456ABCDEF format
        '[A-Fa-f0-9]{12}' {

            $MAC = $MAC.Substring(0,6)

        }
        
        #Matches 12.3A.BC format
        '[A-Fa-f0-9]{2}\.[A-Fa-f0-9]{2}\.[A-Fa-f0-9]{2}' {

            $MAC = $MAC.Replace(".","").Substring(0,6)

        }

        #Matches 12.34.56.AB.DC.EF format
        '[A-Fa-f0-9]{2}\.[A-Fa-f0-9]{2}\.[A-Fa-f0-9]{2}\.[A-Fa-f0-9]{2}\.[A-Fa-f0-9]{2}\.[A-Fa-f0-9]{2}' {

            $MAC = $MAC.Replace(".","").Substring(0,6)

        }

        #Matches 12-3A-BC
        '[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}' {

            $MAC = $MAC.Replace("-","")

        }

        #Matches 12-34-56-AB-CD-EF
        '[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}' {
            
            $MAC = $MAC.Replace("-","").Substring(0,6)

        }

        #Matches 1234-56AB-CDEF
        '[A-Fa-f0-9]{4}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{4}' {

            $MAC = $MAC.Replace("-","").Substring(0,6)

        }

        #Matches 1234.56AB.CDEF
        '[A-Fa-f0-9]{4}.[A-Fa-f0-9]{4}.[A-Fa-f0-9]{4}' {

            $MAC = $MAC.Replace(".","").Substring(0,6)

        }

    }

    $Vendor = ($MACList | Where-Object { $_.MACPrefix -eq $MAC })

    Write-Output $Vendor

}