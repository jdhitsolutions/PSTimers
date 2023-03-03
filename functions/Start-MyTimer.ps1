Function Start-MyTimer {
    [cmdletbinding()]
    [OutputType("MyTimer")]
    [Alias("ton")]

    Param(
        [Parameter(Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string[]]$Name = "MyTimer",
        [string]$Description
    )

    Write-Verbose "Starting: $($MyInvocation.MyCommand)"
    #display PSBoundParameters formatted nicely for Verbose output
    [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
    Write-Verbose "PSBoundParameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n"
    foreach ($timer in $Name) {
        #Test if a timer with the same name already exists
        if (Get-Mytimer -Name $Name -WarningAction SilentlyContinue) {
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
