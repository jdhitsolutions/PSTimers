Function Stop-MyTimer {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType("MyTimer")]
    [Alias("toff")]

    Param(
        [Parameter(Position = 0, Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [String]$Name,
        [Parameter(HelpMessage = "Show the timer.")]
        [Switch]$PassThru
    )
    Begin {
        _verbose ($strings.Starting -f $MyInvocation.MyCommand)
        _verbose ($strings.Running -f $PSVersionTable.PSVersion)
        _verbose ($strings.Detected -f $host.Name)
    }
    Process {
        _verbose ($strings.GettingTimer -f $name)
        $timers = ($global:MyTimerCollection).Values.where( {$_.name -like $name})
        if ($timers) {
            Foreach ($timer in $timers) {
                _verbose ($strings.Processing -f $timer)

                if ($timer.running) {
                    if ($PSCmdlet.ShouldProcess($timer.name)) {
                        $timer.stopTimer()
                        if ($PassThru) {
                            $timer
                        }

                    } #should process
                }
                else {
                    Write-Warning "$($timer.name) is not running"
                }
            }
        }
        else {
            Write-Warning $($strings.NoTimerFound -f $Name)
        }
    }
    End {
        _verbose  ($strings.Ending -f $MyInvocation.MyCommand)
    }
}
