Function Stop-PSCountdownTimer {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType("none")]
    Param( )
    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
    } #begin

    Process {
        Try {
            [void](Get-Variable -Name PSCountdownClock -Scope global -ErrorAction Stop)
            If ($PSCmdlet.ShouldProcess("countdown timer started at $($global:PSCountdownClock.started)")) {
                $rs = $global:PSCountdownClock.RunSpace
                $global:PSCountdownClock.running = $False
                Remove-Variable -Name PSCountdownClock -Scope Global
                Start-Sleep -Seconds 1
                Remove-RunSpace $rs
            }

        }
        Catch {
            Write-Warning "Could not find `$PSCountdownClock in the global scope. Did you start a countdown timer?"
        }
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Stopping PSCountdownClock"
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close Stop-PSCountdownTimer
