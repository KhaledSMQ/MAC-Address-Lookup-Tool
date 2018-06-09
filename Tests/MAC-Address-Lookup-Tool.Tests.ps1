Import-Module "$PSScriptRoot\..\MAC-Address-Lookup-Tool"

Describe "Get-MACVendor" {

    Context "Checking MAC input --> Vendor output" {
    
        Context "Checking all possible input formats return the correct output" {
        
            It "Returns correct result for 123ABC input format" {

                $Error.Clear()
                Remove-Variable Return -ErrorAction SilentlyContinue
                $Return = Get-MACVendor -MAC "BCAEC5"
                $Return.MACVendor | Should Be "ASUS"

            }

            It "Returns correct result for 123456ABCDEF input format" {

                $Error.Clear()
                Remove-Variable Return -ErrorAction SilentlyContinue
                $Return = Get-MACVendor -MAC "BCAEC5971BC9"
                $Return.MACVendor | Should Be "ASUS"

            }

            It "Returns correct result for 12.3A.BC input format" {

                $Error.Clear()
                Remove-Variable Return -ErrorAction SilentlyContinue
                $Return = Get-MACVendor -MAC "BC.AE.C5"
                $Return.MACVendor | Should Be "ASUS"

            }

            It "Returns correct result for 12.34.56.AB.DC.EF input format" {

                $Error.Clear()
                Remove-Variable Return -ErrorAction SilentlyContinue
                $Return = Get-MACVendor -MAC "BC.AE.C5.97.1B.C9"
                $Return.MACVendor | Should Be "ASUS"

            }

            It "Returns correct result for 12-3A-BC input format" {

                $Error.Clear()
                Remove-Variable Return -ErrorAction SilentlyContinue
                $Return = Get-MACVendor -MAC "BC-AE-C5"
                $Return.MACVendor | Should Be "ASUS"

            }

            It "Returns correct result for 12-34-56-AB-CD-EF input format" {

                $Error.Clear()
                Remove-Variable Return -ErrorAction SilentlyContinue
                $Return = Get-MACVendor -MAC "BC-AE-C5-97-1B-C9"
                $Return.MACVendor | Should Be "ASUS"

            }

            It "Returns correct result for 1234-56AB-CDEF input format" {

                $Error.Clear()
                Remove-Variable Return -ErrorAction SilentlyContinue
                $Return = Get-MACVendor -MAC "BCAE-C597-1BC9"
                $Return.MACVendor | Should Be "ASUS"

            }

            It "Returns correct result for 1234.56AB.CDEF input format" {

                $Error.Clear()
                Remove-Variable Return -ErrorAction SilentlyContinue
                $Return = Get-MACVendor -MAC "BCAE.C597.1BC9"
                $Return.MACVendor | Should Be "ASUS"

            }
        
        }

        Context "Checking multi-input works as expected" {

            It "Returns correct results for array input" {

                $Error.Clear()
                Remove-Variable Return -ErrorAction SilentlyContinue
                $Return = Get-MACVendor -MAC '0007B3','DC86D8','001377','94EB2C','B84FD5'
                $Return[0].MACVendor | Should Be "Cisco"
                $Return[1].MACVendor | Should Be "Apple"
                $Return[2].MACVendor | Should Be "Samsung"
                $Return[3].MACVendor | Should Be "Google"
                $Return[4].MACVendor | Should Be "Microsoft"

            }

            It "Returns correct results for pipeline input" {

                $Error.Clear()
                Remove-Variable Return -ErrorAction SilentlyContinue
                $Return = '0007B3','DC86D8','001377','94EB2C','B84FD5' | Get-MACVendor 
                $Return[0].MACVendor | Should Be "Cisco"
                $Return[1].MACVendor | Should Be "Apple"
                $Return[2].MACVendor | Should Be "Samsung"
                $Return[3].MACVendor | Should Be "Google"
                $Return[4].MACVendor | Should Be "Microsoft"

            }

            It "Returns correct results when piping in Get-NetAdapter" {

                $Error.Clear()
                Remove-Variable Return -ErrorAction SilentlyContinue
                $Return = Get-NetAdapter | Select-Object -First 1 | Get-MACVendor
                $Return.MACVendor | Should Be "Microsoft"

            }

        }

    }

    Context "Checking Vendor input --> MAC prefix output" {

        It "Returns the correct number of MAC prefixes for an inputted vendor" {

            $Error.Clear()
            Remove-Variable Return -ErrorAction SilentlyContinue
            $Return = Get-MACVendor -Vendor "OnePlus"
            $Return.count -ge 3
            
        }

    }

    Context "Checking for correct error behavior" {

        It "Errors if given an incorrect MAC format" {

            $Error.Clear()
            Remove-Variable Return -ErrorAction SilentlyContinue
            $Return = Get-MACVendor -MAC "ASDFJKL" -ErrorAction SilentlyContinue
            $Error[0].Exception.Message | Should Be "Input is not a valid MAC address or MAC address prefix!"

        }

        It "Returns nothing if given an invalid vendor name" {

            $Error.Clear()
            Remove-Variable Return -ErrorAction SilentlyContinue
            $Return = Get-MACVendor -Vendor "NOTAREALVENDOR"
            $Return | Should Be $Null

        }

    }

}