Function Start-MyTimer {

    [cmdletbinding()]
    [OutputType([MyTimer])]
    [Alias("ton")]

    Param(
        [Parameter(Position = 0)]
        [ValidateNotNullorEmpty()]
        [string[]]$Name = "MyTimer",
        [string]$Description
    )

    Write-Verbose "Starting: $($MyInvocation.Mycommand)"
    #display PSBoundparameters formatted nicely for Verbose output
    [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
    Write-Verbose "PSBoundparameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n"
    foreach ($timer in $Name) {

        Try {
            Write-Verbose "Creating timer $timer"
            New-Object -TypeName MyTimer -ArgumentList $timer, $Description -ErrorAction stop
        }
        Catch {
            # Write-Warning "Failed to create timer $timer. $($_.exception.message)"
            Throw $_
        }

    } #foreach

    Write-Verbose "Ending: $($MyInvocation.Mycommand)"

}
