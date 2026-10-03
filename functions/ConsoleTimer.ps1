#functions for displaying a standard timer in a PowerShell console session

#region Exported functions

function Start-ConsoleTimer {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('none')]
    [alias('stc')]
    param(
        [Parameter(HelpMessage = 'Specify an ANSI style or console color for the clock display. This setting will have no effect if you are resuming a stopped timer.')]
        [PSDefaultValue(Help = 'Yellow')]
        [ValidateNotNullOrEmpty()]
        [string]$DisplayColor = 'Yellow',

        [Parameter(HelpMessage = 'Add a line border to the display. This setting will have no effect if you are resuming a stopped timer.')]
        [switch]$Border,

        [Parameter(HelpMessage = 'Specify an ANSI or console color for the border. This parameter has no effect unless used with -Border. This setting will have no effect if you are resuming a stopped timer.')]
        [ValidateNotNullOrEmpty()]
        [string]$BorderColor = 'Green',

        [Parameter(HelpMessage = 'Reset and start the console timer beginning at 0 seconds.')]
        [switch]$Reset
    )

    begin {
        _verbose ($strings.Starting -f $MyInvocation.MyCommand)
        if ($MyInvocation.CommandOrigin -eq 'Runspace') {
            _verbose ($strings.Running -f $PSVersionTable.PSVersion)
            _verbose ($strings.UsingModule -f $modVersion)
            _verbose ($strings.Detected -f $Host.Name)
        }
        Write-Information $PSBoundParameters -Tags runtime

        #the action scriptblock needs to be self-contained or able to reference globally scoped items
        $action = {
            #dot source the helper functions from the PSClock module if required
            $modPath = (Get-Module PSTimers).Path | Split-Path -Parent
            $funPath = Join-Path -Path $modPath -ChildPath 'functions\ConsoleTimerHelpers.ps1'
            . $funPath

            if ($global:consoleTimerSettings.Border) {
                #add an offset if there is a Border
                $offSet = 5
            }
            else {
                $offset = 1
            }

            [string]$runTime = if ( $global:consoleTimerSettings.Timer.TotalDays -ge 1 ) {
                $global:consoleTimerSettings.Timer.Elapsed.ToString("dd\.hh\:mm\:ss")
            }  else {
                $global:consoleTimerSettings.Timer.Elapsed.ToString("hh\:mm\:ss")
            }

            $fmtTimer = "{0}$runTime{1}" -f (ConvertTo-AnsiColor $global:consoleTimerSettings.DisplayColor), "$([char]27)[0m"
            #define the cursor position in console
            $here = $host.ui.RawUI.CursorPosition
            $x = $Host.UI.RawUI.WindowSize.Width - $runTime.length - $offSet
            $consolePosition = [System.Management.Automation.Host.Coordinates]::new($x, 0)
            $host.ui.RawUI.CursorPosition = $consolePosition
            if ($global:consoleTimerSettings.Border) {
                Format-BorderBox -Text $fmtTimer -BorderColor (ConvertTo-AnsiColor $global:consoleTimerSettings.BorderColor) -Position $consolePosition
            }
            else {
                Write-Host $fmtTimer -NoNewline
            }
            #reset the cursor position
            $host.ui.RawUI.CursorPosition = $here
            if ($global:consoleTimerSettings.IsRunning) {
                $global:consoleTimerSettings.Timer.Start()
            }

        } #close action

        Write-Information $action
    } #begin

    process {
        if ($host.name -eq 'ConsoleHost') {
            Write-Information -MessageData $myInvocation -Tags process
            Write-Information -MessageData $PSBoundParameters -Tags process

            if ($global:consoleTimerSettings.IsRunning) {
                Write-Warning $strings.ExistingConsoleTimer
                return
            }
            elseif (-not $global:consoleTimerSettings) {
                #create $global:consoleTimerSettings
                _verbose $strings.InitializingConsoleTimer
                $ConsoleTimerParams = @{
                    Name        = 'consoleTimerSettings'
                    Scope       = 'global'
                    Description = 'This is used by the PSTimers module. Do not manually remove.'
                    Value       = [ordered]@{
                        Timer        = [System.Diagnostics.Stopwatch]::new()
                        DisplayColor = ConvertTo-AnsiColor $DisplayColor
                        Border       = $Border
                        BorderColor  = ConvertTo-AnsiColor $BorderColor
                        IsRunning    = $False
                        Started      = Get-Date
                        Note         = 'This is used by the PSTimers module. Do not manually remove.'
                    }
                }
                Set-Variable @ConsoleTimerParams
                Write-Information $global:consoleTimerSettings -Tags runtime
                _verbose $strings.RegisterConsoleTimer
                $global:consoleTimerSettings.IsRunning = $True
                $global:consoleTimerSettings.Timer.Start()
                #Register-EngineEvent doesn't natively support -WhatIf so I have to do it.
                if ($PSCmdlet.ShouldProcess('Start-ConsoleTimer')) {
                    #hide the subscription
                    Register-EngineEvent -SourceIdentifier PowerShell.OnIdle -Action $action -SupportEvent
                    $script:consoleTimerEvent = Get-EventSubscriber -Force | Sort-Object SubscriptionId | Select-Object -Last 1
                    Write-Information $Script:consoleTimerEvent -Tags process
                    #add to the module array for event subscriptions
                    $subs.Add($script:consoleTimerEvent)
                    _verbose ($strings.UsingSubscription -f $script:consoleTimerEvent.SubscriptionID)
                } #WhatIf
            } #initialize new

            if ($Reset) {
                _verbose ($strings.ResettingTimer -f $script:consoleTimerEvent.SubscriptionID)
                $global:consoleTimerSettings.Timer.Restart()
                $global:consoleTimerSettings.IsRunning = $True
            }
            elseif ((-not $global:consoleTimerSettings.IsRunning) -and $global:consoleTimerSettings.Timer.Elapsed.TotalSeconds -gt 0) {
                _verbose ($strings.RestartingTimer -f $script:consoleTimerEvent.SubscriptionID)
                $global:consoleTimerSettings.Timer.Start()
                $global:consoleTimerSettings.IsRunning = $True
            }
        } #if console host
        else {
            Write-Warning $strings.InvalidHost
        }
    } #process

    end {
        _verbose ($strings.Ending -f $MyInvocation.MyCommand)
    } #end

} #close Start-ConsoleTimer
function Stop-ConsoleTimer {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('none')]
    param()

    begin {
        _verbose ($strings.Starting -f $MyInvocation.MyCommand)
        if ($MyInvocation.CommandOrigin -eq 'Runspace') {
            _verbose ($strings.Running -f $PSVersionTable.PSVersion)
            _verbose ($strings.UsingModule -f $modVersion)
            _verbose ($strings.Detected -f $Host.Name)
        }
    } #begin

    process {
        _verbose $strings.StoppingConsoleTimer
        $global:consoleTimerSettings.Timer.Stop()
        $global:consoleTimerSettings.IsRunning = $False
    } #process

    end {
        _verbose ($strings.Ending -f $MyInvocation.MyCommand)
    } #end

} #close Stop-ConsoleTimer

function Remove-ConsoleTimer {
    [cmdletBinding()]
    [OutputType('none')]
    param(
        [Parameter(HelpMessage = 'Clear the console host after removing the console timer.')]
        [Alias('cls')]
        [switch]$ClearHost
    )

    begin {
        _verbose ($strings.Starting -f $MyInvocation.MyCommand)
        if ($MyInvocation.CommandOrigin -eq 'Runspace') {
            _verbose ($strings.Running -f $PSVersionTable.PSVersion)
            _verbose ($strings.UsingModule -f $modVersion)
            _verbose ($strings.Detected -f $Host.Name)
        }
    } #begin

    process {
        if ($script:consoleTimerEvent) {
            _verbose ($strings.Unregister -f $($script:consoleTimerEvent.SubscriptionId))
            Unregister-Event -SubscriptionId $script:consoleTimerEvent.SubscriptionId -Force
            Remove-Variable -Name consoleTimerEvent -Scope Script -Force -ErrorAction SilentlyContinue
            Remove-Variable -Name consoleTimerSettings -Scope global -Force -ErrorAction SilentlyContinue
            $removed = $true
        }
        else {
            Write-Warning $strings.NoConsoleTimer
        }
    } #process
    end {
        _verbose ($strings.Ending -f $MyInvocation.MyCommand)
        if ($ClearHost -and $removed) {
            Clear-Host
        }
    } #end
}

#endregion