Function Get-MACVendor {

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