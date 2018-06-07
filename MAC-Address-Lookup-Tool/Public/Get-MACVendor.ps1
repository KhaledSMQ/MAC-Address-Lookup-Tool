Function Get-MACVendor {

    [CmdletBinding()]
    Param (

        [Parameter(Position=0,Mandatory=$True,ParameterSetName='LookupByMAC')]
        [String]$MAC,

        [Parameter(Position=0,Mandatory=$True,ParameterSetName='LookupByVendor')]
        [String]$Vendor

    )

    $MACList = Parse-MACPrefixList

    Switch ($PSCmdlet.ParameterSetName) {

        'LookupByMAC' {

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
        
            $Output = ($MACList | Where-Object { $_.MACPrefix -eq $MAC })
            
        }

        'LookupByVendor' {

            $Output = $MACList | Where-Object { $_.MACVendor -eq $Vendor }
            
        }

    }

    Write-Output $Output
    
}