#functions for displaying a countdown timer in a PowerShell console session

#region Exported functions

function Start-ConsoleCountdown {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('none')]
    [Alias('stcd')]
    param(
        [Parameter(
            Position = 0,
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'The number of seconds for the countdown.'
        )]
        [ValidateScript({ $_ -gt 0 })]
        [int32]$Seconds,

        [Parameter(
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Specify the text to display after the countdown completes in 25 characters or less.'
        )]
        [ValidateLength(1, 25)]
        [string]$PostCountdownText,

        [Parameter(HelpMessage = 'Specify an ANSI style or console color for the clock display.')]
        [PSDefaultValue(Help = 'Yellow')]
        [ValidateNotNullOrEmpty()]
        [string]$DisplayColor = 'Yellow',

        [Parameter(HelpMessage = 'Add a line border to the display.')]
        [switch]$Border,

        [Parameter(HelpMessage = 'Specify an ANSI or console color for the border. This parameter has no effect unless used with -Border')]
        [ValidateNotNullOrEmpty()]
        [string]$BorderColor = 'Green'
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
            #if the global settings hashtable is removed, do not run and stop the countdown
            if (-not $global:consoleCountdownSettings) {
                Stop-ConsoleCountdown
                return
            }

            #dot source the helper functions from the PSClock module if required
            $modPath = (Get-Module PSTimers).path | Split-Path -Parent
            $funPath = Join-Path -Path $modPath -ChildPath 'functions\ConsoleTimerHelpers.ps1'
            . $funPath
            if ($global:consoleCountdownSettings.Border) {
                #add an offset if there is a Border
                $offSet = 5
            }
            else {
                $offset = 1
            }

            if (($global:consoleCountdownSettings.target -gt $global:consoleCountdownSettings.Timer.Elapsed)) {
                $global:consoleCountdownSettings.IsRunning = $True
                [string]$dtCountdown = '{0:hh\:mm\:ss}' -f ($global:consoleCountdownSettings.Target - $global:consoleCountdownSettings.Timer.Elapsed)
            }
            elseif ($global:consoleCountdownSettings.Timer.Elapsed -gt $global:consoleCountdownSettings.target) {
                $global:consoleCountdownSettings.IsRunning = $False
                $global:consoleCountdownSettings.Timer.Stop()
                if ($global:consoleCountdownSettings.PostText) {
                    [string]$dtCountdown = $global:consoleCountdownSettings.PostText
                }
                else {
                     [string]$dtCountdown = "00:00:00"
                     Stop-ConsoleCountdown
                     Return
                }
            }

            $fmtCountDown = "{0}$dtCountdown{1}" -f (ConvertTo-AnsiColor $global:consoleCountdownSettings.DisplayColor), "$([char]27)[0m"
            #define the cursor position in console
            $here = $host.ui.RawUI.CursorPosition
            $x = $Host.UI.RawUI.WindowSize.Width - $dtCountdown.length - $offSet
            $consolePosition = [System.Management.Automation.Host.Coordinates]::new($x, 0)
            $host.ui.RawUI.CursorPosition = $consolePosition
            if ($global:consoleCountdownSettings.Border) {
                Format-BorderBox -Text $fmtCountDown -BorderColor (ConvertTo-AnsiColor $global:consoleCountdownSettings.BorderColor) -Position $consolePosition
            }
            else {
                Write-Host $fmtCountDown -NoNewline
            }
            #reset the cursor position
            $host.ui.RawUI.CursorPosition = $here

        } #close action

        Write-Information $action

    } #begin

    process {
        if ($host.name -eq 'ConsoleHost') {
            _verbose ($strings.StartConsoleCountdown -f (New-TimeSpan -Seconds $Seconds) )

            Write-Information -MessageData $myInvocation -Tags process
            Write-Information -MessageData $PSBoundParameters -Tags process

            #create $global:consoleCountdownSettings
            $consoleCountdownParams = @{
                Name        = 'consoleCountdownSettings'
                Scope       = 'global'
                Description = 'This is used by the PSTimers module. Do not manually remove.'
                Value       = [ordered]@{
                    Timer        = [System.Diagnostics.Stopwatch]::new()
                    Target       = New-TimeSpan -Seconds $Seconds
                    PostText     = $PostCountdownText
                    DisplayColor = ConvertTo-AnsiColor $DisplayColor
                    Border       = $Border
                    BorderColor  = ConvertTo-AnsiColor $BorderColor
                    IsRunning    = $False
                    Note         = 'This is used by the PSTimers module. Do not manually remove.'
                }
            }
            Set-Variable @consoleCountdownParams
            Write-Information $global:consoleCountdownSettings -Tags runtime
            if ($global:consoleCountdownSettings.IsRunning) {
                Write-Warning $strings.ExistingConsoleCountdown
            }
            else {
                _verbose $strings.RegisterConsoleCountdown
                #Register-EngineEvent doesn't natively support -WhatIf so I have to do it.
                if ($PSCmdlet.ShouldProcess('Start-ConsoleCountdown')) {
                    #hide the subscription
                    Register-EngineEvent -SourceIdentifier PowerShell.OnIdle -Action $action -SupportEvent
                    $script:countdownEvent = Get-EventSubscriber -Force | Sort-Object SubscriptionId | Select-Object -Last 1
                    #add to the module array for event subscriptions
                    $subs.Add($script:countdownEvent)
                    _verbose ($strings.UsingSubscription -f $script:countdownEvent.SubscriptionID)

                    $global:consoleCountdownSettings.Timer.Start()
                    $global:consoleCountdownSettings.IsRunning = $True
                } #WhatIf
            } #no existing countdown in the console
        } #if console host
        else {
            Write-Warning $strings.InvalidHost
        }
    } #process

    end {
        _verbose ($strings.Ending -f $MyInvocation.MyCommand)
    } #end

} #close Start-ConsoleCountdown

function Stop-ConsoleCountdown {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('none')]
    param( )

    begin {
        _verbose ($strings.Starting -f $MyInvocation.MyCommand)
        if ($MyInvocation.CommandOrigin -eq 'Runspace') {
            _verbose ($strings.Running -f $PSVersionTable.PSVersion)
            _verbose ($strings.UsingModule -f $modVersion)
            _verbose ($strings.Detected -f $Host.Name)
        }
    } #begin

    process {
        _verbose $strings.StoppingConsoleCountdown
        if ($script:countdownEvent) {
            _verbose ($strings.Unregister -f $($script:countdownEvent.SubscriptionId))
            Unregister-Event -SubscriptionId $script:countdownEvent.SubscriptionId -Force
            Remove-Variable -Name countdownEvent -Scope Script -Force -ErrorAction SilentlyContinue
            Remove-Variable -Name consoleCountdownSettings -Scope Global -Force -ErrorAction SilentlyContinue
        }
        else {
            Write-Warning $strings.NoConsoleCountdown
        }
    } #process

    end {
        _verbose ($strings.Ending -f $MyInvocation.MyCommand)
    } #end

} #close Stop-ConsoleCountdown

#endregion