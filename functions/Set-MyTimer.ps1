Function Set-MyTimer {

    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("MyTimer")]
    Param(
        [Parameter(Position = 0, Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [string]$NewName,
        [datetime]$Start,
        [string]$Description,
        [switch]$PassThru
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"
    } #begin

    Process {
        #display PSBoundParameters formatted nicely for Verbose output
        [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
        Write-Verbose "[PROCESS] PSBoundParameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n"

        $timers = ($global:MyTimerCollection).Values.where( {$_.name -like $name})

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
                    if ($PassThru) {
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
        Write-Verbose "[END    ] Ending: $($MyInvocation.MyCommand)"
    }
}
