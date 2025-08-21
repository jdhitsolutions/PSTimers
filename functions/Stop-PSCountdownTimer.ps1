Function Stop-PSCountdownTimer {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType("none")]
    Param( )
    Begin {
        _verbose  ($strings.starting -f $MyInvocation.MyCommand)
        _verbose ($strings.Running -f $PSVersionTable.PSVersion)
        _verbose ($strings.Detected -f $host.Name)
    } #begin

    Process {
        Try {
            [void](Get-Variable -Name PSCountdownClock -Scope global -ErrorAction Stop)
            If ($PSCmdlet.ShouldProcess($($Strings.StartedCountdown -f $global:PSCountdownClock.started))) {
                $rs = $global:PSCountdownClock.RunSpace
                $global:PSCountdownClock.running = $False
                Remove-Variable -Name PSCountdownClock -Scope Global
                Start-Sleep -Seconds 1
                Remove-RunSpace $rs
            }
        }
        Catch {
            Write-Warning $strings.NoCountDownTimer
        }
        _verbose ($strings.Ending -f $MyInvocation.MyCommand)
    } #process"

    End {
        _verbose  ($strings.Ending -f  $MyInvocation.MyCommand)
    } #end

} #close Stop-PSCountdownTimer
