Function Set-MyTimer {

    [cmdletbinding(SupportsShouldProcess)]
    [OutputType([MyTimer[]])]
    Param(
        [Parameter(Position = 0, Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullorEmpty()]
        [string]$Name,
        [string]$NewName,
        [datetime]$Start,
        [string]$Description,
        [switch]$Passthru
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
    } #begin

    Process {
        #display PSBoundparameters formatted nicely for Verbose output
        [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
        Write-Verbose "[PROCESS] PSBoundparameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n"

        $timers = ($global:myTimerCollection).Values.where( {$_.name -like $name})

        if ($timers.count -ge 1) {
            foreach ($timer in $timers) {
                Write-Verbose "[PROCESS] Setting timer $($timer.name)"
                if ($PSCmdlet.ShouldProcess($Name)) {
                    if ($Description) {
                        $timer.description = $Description
                    }
                    if ($NewName) {
                        $timer.Name = $NewName
                    }
                    if ($start) {
                        $timer.start = $Start
                    }
                    if ($Passthru) {
                        $timer
                    }
                }
            } #foreach
        } #if $timers
        else {
            Write-Warning "Can't find a matching timer object"
        }
    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    }
}
