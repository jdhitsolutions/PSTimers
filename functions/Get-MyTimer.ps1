Function Get-MyTimer {
    [cmdletbinding(DefaultParameterSetName = "name")]
    [OutputType("MyTimer")]
    Param(
        [Parameter(
            Position = 0,
            ValueFromPipelineByPropertyName,
            ParameterSetName = "name"
        )]
        [ValidateNotNullOrEmpty()]
        [SupportsWildcards()]
        [string[]]$Name,

        [Parameter(
            ParameterSetName = "status",
            HelpMessage = "Filter timers based on status"
        )]
        [ValidateSet("Running","Stopped","Paused","Reset")]
        [string]$Status
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"
    } #begin

    Process {
        Write-Verbose "[PROCESS] Using PSBoundParameters: `n $(New-Object PSObject -Property $PSBoundParameters | Out-String)"
        If ($PSCmdlet.ParameterSetName -eq "Name") {
            if ($Name) {
                Write-Verbose "[PROCESS] Getting timer $Name"
                $timers = foreach ($item in $Name) {
                    ($global:MyTimerCollection).Values.where( {$_.name -like $item})
                }
            }
            else {
                #find all timers by default
                Write-Verbose "[PROCESS] Getting all timers"
                $timers = $global:MyTimerCollection.Values
            }
            if ($timers.count -eq 0 -AND $Name) {
                $warn = "Can't find any matching timer objects with the name $Name."
                Write-Warning $warn
            }
            elseif ($timers.count -eq 0) {
                $warn = "No defined timers found. Use Start-MyTimer to create one."
                Write-Warning $warn
            }
        }
        Else {
            Write-Verbose "[PROCESS] Getting all timers with a status of $Status"
            $timers = ($global:MyTimerCollection.Values).Where({$_.status -eq $Status})
            if ($timers.count -eq 0) {
                $warn = "No timers found with a status of $Status"
                Write-Warning $warn
            }
        }

        Write-Verbose "[PROCESS] Found $($timers.count) matching timer(s)"
        Write-Verbose "[PROCESS] Getting timer status"
        if ($timers.count -ge 1) {
            foreach ($timer in ($timers | Sort-Object -Property Start)) {
                if ($timer.running) {
                    $timer.Refresh()
                }
                $timer
            }#foreach
        } #if $timers
    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.MyCommand)"
    }
}
