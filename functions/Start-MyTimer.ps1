Function Start-MyTimer {
    [cmdletbinding()]
    [OutputType("MyTimer")]
    [Alias("ton")]

    Param(
        [Parameter(Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string[]]$Name = "MyTimer",
        [String]$Description
    )

    Write-Verbose "Starting: $($MyInvocation.MyCommand)"
    Write-Verbose "Using PSBoundParameters: `n $(New-Object PSObject -Property $PSBoundParameters | Out-String)"
        foreach ($timer in $Name) {
        #Test if a timer with the same name already exists
        if (Get-MyTimer -Name $Name -WarningAction SilentlyContinue) {
            Write-Warning "A timer with the name $Name already exists. Try again with a different name."
        }
        else {
            Try {
                Write-Verbose "Creating timer $timer"
                New-Object -TypeName MyTimer -ArgumentList $timer, $Description -ErrorAction stop
            }
            Catch {
                # Write-Warning "Failed to create timer $timer. $($_.exception.message)"
                Throw $_
            }
        }

    } #foreach

    Write-Verbose "Ending: $($MyInvocation.MyCommand)"

}
