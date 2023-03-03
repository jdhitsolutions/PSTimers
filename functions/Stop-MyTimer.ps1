Function Stop-MyTimer {

    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("MyTimer")]
    [Alias("toff")]

    Param(
        [Parameter(Position = 0, Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]$Name
    )
    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"
        #display PSBoundParameters formatted nicely for Verbose output
        [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
        Write-Verbose "[BEGIN  ] PSBoundParameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n"

    }
    Process {
        Write-Verbose "[PROCESS] Getting timer $name"
        $timers = ($global:MyTimerCollection).Values.where( {$_.name -like $name})
        if ($timers) {
            Foreach ($timer in $timers) {
                write-verbose "[PROCESS] Processing $( $timer | Out-string)"
                if ($timer.running) {
                    if ($PSCmdlet.ShouldProcess($timer.name)) {
                        $timer.stopTimer()

                        Get-MyTimer -name $timer.name | Select-Object -Property History

                    } #should process
                }
                else {
                    write-warning "$($timer.name) is not running"
                }
            }
        }
        else {
            Write-Warning "Can't find a timer called $Name. You need to start the timer first."
        }
    }
    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.MyCommand)"
    }
}
