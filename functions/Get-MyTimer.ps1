Function Get-MyTimer {
    [cmdletbinding()]
    [OutputType("MyTimer")]
    Param(
        [Parameter(Position = 0, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string[]]$Name
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"
    } #begin

    Process {
        Write-Verbose "[PROCESS] Using PSBoundParameters: `n $(New-Object PSObject -Property $PSBoundParameters | Out-String)"
        if ($Name) {
            Write-Verbose "[PROCESS] Getting timer $Name"
            $timers = foreach ($item in $Name) {
                ($global:MyTimerCollection).Values.where( {$_.name -like $item})
            }
        }
        else {
            #find all running timers by default
            Write-Verbose "[PROCESS] Getting all timers"
            $timers = $global:MyTimerCollection.Values
        }

        Write-Verbose "[PROCESS] Getting current timer status"
        if ($timers.count -ge 1) {
            foreach ($timer in ($timers | Sort-Object -Property Start)) {
                if ($timer.running) {
                    #set the duration to the current value
                    $timer.duration = $timer.GetStatus()
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
        Write-Verbose "[END    ] Ending: $($MyInvocation.MyCommand)"
    }
}
