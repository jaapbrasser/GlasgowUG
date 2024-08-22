Describe 'Get-PikachuData' {
    # Mock a successful API response
    Context 'when the API returns a successful response' {
        It 'should return a PowerShell object with Pikachu data' {
            # Mocking the Invoke-RestMethod cmdlet
            Mock -CommandName Invoke-RestMethod -MockWith {
                return @{
                    StatusCode = 200
                    name       = "pikachu"
                    id         = 25
                    abilities  = @("static", "lightning-rod")
                    types      = @("electric")
                    stats      = @{}
                }
            }

            $result = Get-PikachuData

            # Assertions
            $result | Should -BeOfType 'pscustomobject'
            
            $result.Id | Should -Be 25
        }
        It 'should return a PowerShell object with Pikachu`s Name' {
            # Mocking the Invoke-RestMethod cmdlet
            Mock -CommandName Invoke-RestMethod -MockWith {
                return @{
                    StatusCode = 200
                    name       = "pikachu"
                    id         = 25
                    abilities  = @("static", "lightning-rod")
                    types      = @("electric")
                    stats      = @{}
                }
            }

            $result = Get-PikachuData

            # Assertions
            $result.Name | Should -Be 'pikachu'
        }
        It 'should return a PowerShell object with Pikachu`s correct type "Electric"' {
            # Mocking the Invoke-RestMethod cmdlet
            Mock -CommandName Invoke-RestMethod -MockWith {
                return @{
                    StatusCode = 200
                    name       = "pikachu"
                    id         = 25
                    abilities  = @("static", "lightning-rod")
                    types      = @(@{type = @{name = "electric"}})
                    stats      = @{}
                }
            }

            $result = Get-PikachuData

            # Assertions
            $result.types | Should -Be 'electric'
        }
    }

    # Mock a 400 series client error response
    Context 'when the API returns a client error' {
        It 'should handle the error and display an appropriate message' {
            Mock -CommandName Invoke-RestMethod -MockWith {
                throw [System.Net.WebException]::new("Client error", [System.Net.WebExceptionStatus]::ProtocolError)
            }

            # Pester's ShouldThrow is used for verifying that an error was thrown
            { Get-PikachuData } | Should -Throw
        }
    }

    # Mock a 500 series server error response
    Context 'when the API returns a server error' {
        It 'should handle the error and display an appropriate message' {
            Mock -CommandName Invoke-RestMethod -MockWith {
                throw [System.Net.WebException]::new("Server error", [System.Net.WebExceptionStatus]::ProtocolError)
            }

            { Get-PikachuData } | Should -Throw
        }
    }

    # Mock a 800 series server error response, to emulate a non-standard error
    Context 'when the API returns an unexpected error' {
        It 'should handle the error and display an appropriate message' {
            Mock -CommandName Invoke-RestMethod -MockWith {
                throw [System.Net.WebException]::new("Server error", [System.Net.WebExceptionStatus]::ProtocolError)
            }

            { Get-PikachuData } | Should -Throw
        }
    }
}
