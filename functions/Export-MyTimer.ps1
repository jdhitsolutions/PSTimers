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
        [ValidateNotNullorEmpty()]
        [string]$Path
    )

    Write-Verbose "Starting: $($MyInvocation.Mycommand)"
    #display PSBoundparameters formatted nicely for Verbose output
    [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
    Write-Verbose "PSBoundparameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n"

    if ($Name) {
        Write-Verbose "Finding timer variable $Name"
        $found = $global:mytimercollection["$name"]
    }
    else {
        Write-Verbose "Finding all timer variables"
        $found = $global:mytimercollection.values
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

    Write-Verbose "Ending: $($MyInvocation.Mycommand)"
}
