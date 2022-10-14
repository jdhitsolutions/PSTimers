

Function Stop-PSCountdownTimer {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("none")]
    Param( )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
    } #begin

    Process {
        Try {
            [void](Get-Variable -Name PSCountdownClock -Scope global -ErrorAction Stop)
            If ($PSCmdlet.ShouldProcess("countdown timer started at $($global:PSCountdownclock.started)")) {
                $rs = $global:pscountdownclock.runspace
                $global:PSCountdownclock.running = $False
                Remove-Variable -Name PSCountdownClock -Scope Global
                Start-Sleep -Seconds 1
                Remove-Runspace $rs
            }

        }
        Catch {
            Write-Warning "Could not find `$PSCountdownClock in the global scope. Did you start a countdown timer?"
        }
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Stopping PSCountDownClock"
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

} #close Stop-PSCountdownTimer