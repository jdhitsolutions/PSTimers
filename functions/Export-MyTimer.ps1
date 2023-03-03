Function Export-MyTimer {

    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("None")]
    Param(
        [Parameter(Position = 0)]
        [string]$Name,

        [Parameter(
            Mandatory,
            HelpMessage = "Enter the name and path of an XML file"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$Path
    )

    Write-Verbose "Starting: $($MyInvocation.MyCommand)"
    #display PSBoundParameters formatted nicely for Verbose output
    [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
    Write-Verbose "PSBoundParameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n"

    if ($Name) {
        Write-Verbose "Finding timer variable $Name"
        $found = $global:MyTimerCollection["$name"]
    }
    else {
        Write-Verbose "Finding all timer variables"
        $found = $global:MyTimerCollection.values
    }

    If ($found) {
        Try {
            Write-Verbose "Exporting timers to $Path"
            $found | Export-Clixml -Path $path -ErrorAction Stop
        }
        Catch {
            Write-Error $_
        }
    }
    else {
        Write-Warning "No matching timers found."
    }

    Write-Verbose "Ending: $($MyInvocation.MyCommand)"
}
