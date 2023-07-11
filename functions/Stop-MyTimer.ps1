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
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"
    }
    Process {

        Write-Verbose "[PROCESS] Using PSBoundParameters: `n $(New-Object PSObject -Property $PSBoundParameters | Out-String)"
        Write-Verbose "[PROCESS] Getting timer $name"
        $timers = ($global:MyTimerCollection).Values.where( {$_.name -like $name})
        if ($timers) {
            Foreach ($timer in $timers) {
                Write-Verbose "[PROCESS] Processing $( $timer | Out-String)"
                if ($timer.running) {
                    if ($PSCmdlet.ShouldProcess($timer.name)) {
                        $timer.stopTimer()
                        if ($PassThru) {
                            $timer
                        }

                        # Get-MyTimer -name $timer.name | Select-Object -Property History

                    } #should process
                }
                else {
                    Write-Warning "$($timer.name) is not running"
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
