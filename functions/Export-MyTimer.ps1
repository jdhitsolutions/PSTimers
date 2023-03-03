Function Export-MyTimer {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("None")]
    Param(
        [Parameter(Position = 0)]
        [String]$Name,

        [Parameter(
            Mandatory,
            HelpMessage = "Enter the name and path of an XML file"
        )]
        [ValidateNotNullOrEmpty()]
        [String]$Path
    )

    Write-Verbose "Starting: $($MyInvocation.MyCommand)"
    Write-Verbose "Using PSBoundParameters: `n $(New-Object PSObject -Property $PSBoundParameters | Out-String)"
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
