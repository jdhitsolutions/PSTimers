Function Get-MyTimer {

    [cmdletbinding()]
    [OutputType([MyTimer[]])]
    Param(
        [Parameter(Position = 0, ValueFromPipelineByPropertyName)]
        [ValidateNotNullorEmpty()]
        [string[]]$Name
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
    } #begin

    Process {
        #display PSBoundparameters formatted nicely for Verbose output
        [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
        Write-Verbose "[PROCESS] PSBoundparameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n"

        if ($Name) {
            Write-Verbose "[PROCESS] Getting timer $Name"
            $timers = foreach ($item in $Name) {
                ($global:MytimerCollection).Values.where( {$_.name -like $item})
            }
        }
        else {
            #find all running timers by default
            Write-Verbose "[PROCESS] Getting all timers"
            $timers = $global:myTimerCollection.Values
        }

        Write-Verbose "[PROCESS] Getting current timer status"
        if ($timers.count -ge 1) {
            foreach ($timer in ($timers | Sort-Object -Property Start)) {
                if ($timer.running) {
                    #set the duration to the current value
                    $timer.duration = $timer.Getstatus()
                    $timer
                    #set duration back to 0
                    $timer.duration = 0
                }
                else {
                    #update Duration value if timer is stopped and it hasn't been updated
                    if ($timer.duration.seconds -eq 0) {
                        write-Verbose "Correcting duration on $($timer.name)"
                        $timer.Duration = $timer.end - $timer.start
                    }
                    $timer
                }

            }#foreach
        } #if $timers
        else {
            if ($name) {
                $warn = "Can't find any matching timer objects with the name $Name."
            }
            else {
                $warn = "No defined timers found. Use Start-MyTimer to create one."
            }
            Write-Warning $warn
        }
    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    }
}
