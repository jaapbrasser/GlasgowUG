function Get-PikachuData {
    [CmdletBinding()]
    param()

    $url = "https://pokeapi.co/api/v2/pokemon/pikachu"

    try {
        $response = Invoke-RestMethod -Uri $url -Method Get -ErrorAction Stop
        return [pscustomobject]@{
            Name       = $response.name
            Id         = $response.id
            Abilities  = $response.abilities.ability.name -join ', '
            Types      = $response.types.type.name
        }

    } catch {
        # Handle client errors (400 series)
        if ($_.Exception.Response.StatusCode -ge 400 -and $_.Exception.Response.StatusCode -lt 500) {
            throw "Client error occurred: $($_.Exception.Message)"
        }
        # Handle server errors (500 series)
        elseif ($_.Exception.Response.StatusCode -ge 500 -and $_.Exception.Response.StatusCode -lt 600) {
            throw "Server error occurred: $($_.Exception.Message)"
        } else {
            # General error handling
            throw "An error occurred: $($_.Exception.Message)" 
        }
    }
}

