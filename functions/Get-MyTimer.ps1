Function Get-MyTimer {
    [CmdletBinding(DefaultParameterSetName = "name")]
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
        [String]$Status
    )

    Begin {
        _verbose ($strings.Starting -f $MyInvocation.MyCommand)
        _verbose ($strings.Running -f $PSVersionTable.PSVersion)
        _verbose ($strings.Detected -f $host.Name)
    } #begin

    Process {
        _verbose ($strings.DetectedParamSet -f $PSCmdlet.ParameterSetName)
        If ($PSCmdlet.ParameterSetName -eq "Name") {
            if ($Name) {
                _verbose ($strings.GettingTimer -f $Name)
                $timers = foreach ($item in $Name) {
                    ($global:MyTimerCollection).Values.where( {$_.name -like $item})
                }
            }
            else {
                #find all timers by default
                _verbose $strings.GettingAll
                $timers = $global:MyTimerCollection.Values
            }
            if ($timers.count -eq 0 -AND $Name) {
                Write-Warning ($strings.WarnNoNamedTimer -f $Name)
            }
            elseif ($timers.count -eq 0) {
                Write-Warning $warn.WarnNoTimersFound
            }
        }
        Else {
            _verbose ($strings.GettingAllStatus -f $Status)
            $timers = ($global:MyTimerCollection.Values).Where({$_.status -eq $Status})
            if ($timers.count -eq 0) {
                Write-Warning ($strings.WarnNoTimerStatus -f $status)
            }
        }

        _verbose ($strings.FoundMatchingTimer -f $Timers.count)
        _verbose $strings.GettingTimerStatus
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
        _verbose  ($strings.Ending -f $MyInvocation.MyCommand)
    }
}
