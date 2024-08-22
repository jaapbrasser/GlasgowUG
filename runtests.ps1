$PesterSplat = @{
    PassThru = $false
    Output = 'Detailed'
}

. ./Get-PikachuData.ps1

Invoke-Pester @PesterSplat