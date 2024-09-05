Function Start-PSCountdown {
    [CmdletBinding(DefaultParameterSetName = "minutes")]
    [OutputType("None")]
    [Alias("spsc")]

    Param(
        [Parameter(Position = 0, HelpMessage = "Enter the number of minutes to countdown (1-60). The default is 5.", ParameterSetName = "minutes")]
        [ValidateRange(1, 60)]
        [int32]$Minutes = 5,
        [Parameter(Position = 0, ParameterSetName = "time", HelpMessage = "Enter a datetime value as the countdown target.")]
        [DateTime]$Time,
        [Parameter(HelpMessage = "Enter the text for the progress bar title.")]
        [ValidateNotNullOrEmpty()]
        [String]$Title = "Counting Down ",
        [Parameter(Position = 1, HelpMessage = "Enter a primary message to display in the parent window.")]
        [ValidateNotNullOrEmpty()]
        [String]$Message = "Starting soon.",
        [Parameter(HelpMessage = "Use this parameter to clear the screen prior to starting the countdown.")]
        [alias("cls")]
        [Switch]$ClearHost,
        [ValidateSet("Default", "Random", "Transparent")]
        [alias("style")]
        [String]$ProgressStyle = "Default",
        [Parameter(HelpMessage = "The path to a text list of pseudo-tasks")]
        [ValidateNotNullOrEmpty()]
        [String]$Path = "$PSScriptRoot\..\PSCountdownTasks.txt"
    )
    Begin {
        Write-Verbose "Starting $($MyInvocation.MyCommand)"
        Write-Verbose "Using PSBoundParameters: `n $(New-Object PSObject -Property $PSBoundParameters | Out-String)"

        if ($PSBoundParameters.ContainsKey('progressStyle')) {
            if ($PSBoundParameters.Item('ProgressStyle') -ne 'default') {
                if ($PSStyle) {
                    $saved = $PSStyle.Progress.style
                }
                else {
                    $saved = $host.privateData.ProgressBackgroundColor
                }
            }
            if ($PSBoundParameters.Item('ProgressStyle') -eq 'transparent' -AND ($PSedition -eq 'Desktop' -OR $PSStyle.Progress.view -eq 'classic')) {
                #This only works for Windows PowerShell
                $host.privateData.progressBackgroundColor = $host.UI.RawUI.BackgroundColor
            }
        }
        Write-Verbose "Using parameter set $($PSCmdlet.ParameterSetName)"

        if (Test-Path $Path) {
            #import entries from list without a # comment and trim each one
            Write-Verbose "Loading task messages from $path"
            $loading = Get-Content -Path $Path |
            Where-Object { $_ -match "\w+" -AND $_ -notmatch '#' } | ForEach-Object { $_.Trim() }
        }
        else {
            Write-Verbose "$Path not found. Using default values."
            $loading = "Warming up the room", "Charging batteries", "Formatting C:"
        }
        if ($ClearHost) {
            Clear-Host
        }
        $startTime = Get-Date
        if ($PSCmdlet.ParameterSetName -eq 'minutes') {
            Write-Verbose "Adding $minutes minutes to start time"
            $endTime = $startTime.AddMinutes($Minutes)
        }
        else {
            Write-Verbose "Using Time value"
            $endTime = $Time
        }
        $totalSeconds = (New-TimeSpan -Start $startTime -End $endTime).TotalSeconds

        $totalSecondsChild = Get-Random -Minimum 4 -Maximum 30
        $startTimeChild = $startTime
        $endTimeChild = $startTimeChild.AddSeconds($totalSecondsChild)
        $loadingMessage = $loading[(Get-Random -Minimum 0 -Maximum ($loading.Length - 1))]

        #used when progress style is random
        if ($PSStyle.Progress.view -eq "Minimal") {
            $progColors = $PSStyle.Foreground.brightRed,$PSStyle.Foreground.BrightCyan,$PSStyle.Foreground.brightgreen,
            $PSStyle.Foreground.BrightMagenta
        }
        else {
            $progColors = "black", "darkgreen", "magenta", "blue", "darkgray","cyan","darkcyan"
        }

    } #begin
    Process {
        #this does not work in VS Code or the PowerShell ISE
        if ($host.name -match 'Visual Studio Code|ISE') {
            Write-Warning "This command will not work in the integrated PowerShell Console in VS Code or the PowerShell ISE."
            #bail out
            Return
        }
        Do {
            $now = Get-Date
            $secondsElapsed = (New-TimeSpan -Start $startTime -End $now).TotalSeconds
            $secondsRemaining = $totalSeconds - $secondsElapsed
            $percentDone = ($secondsElapsed / $totalSeconds) * 100

            Write-Progress -Id 0 -Activity $Title -Status $Message -PercentComplete $percentDone -SecondsRemaining $secondsRemaining

            $secondsElapsedChild = (New-TimeSpan -Start $startTimeChild -End $now).TotalSeconds
            $secondsRemainingChild = $totalSecondsChild - $secondsElapsedChild
            $percentDoneChild = ($secondsElapsedChild / $totalSecondsChild) * 100

            if ($percentDoneChild -le 100) {
                Write-Progress -Id 1 -ParentId 0 -Activity $loadingMessage -PercentComplete $percentDoneChild -SecondsRemaining $secondsRemainingChild
            }

            if ($percentDoneChild -ge 100 -and $percentDone -le 98) {
                if ($PSBoundParameters.ContainsKey('ProgressStyle') -AND $PSBoundParameters.Item('ProgressStyle') -eq 'random') {
                    if ($PSStyle.Progress.View -eq 'Minimal') {
                        $PSStyle.Progress.Style = ($progColors | Get-Random)
                    }
                    else {
                        $host.privateData.progressBackgroundColor = ($progColors | Get-Random)
                    }
                }
                $totalSecondsChild = Get-Random -Minimum 4 -Maximum 30
                $startTimeChild = $now
                $endTimeChild = $startTimeChild.AddSeconds($totalSecondsChild)
                if ($endTimeChild -gt $endTime) {
                    $endTimeChild = $endTime
                }
                $loadingMessage = $loading[(Get-Random -Minimum 0 -Maximum ($loading.Length - 1))]
            }

            Start-Sleep 0.2
        } Until ($now -ge $endTime)
    } #progress

    End {
        if ($saved) {
            #restore value if it has been changed
            if ($PSStyle) {
                $PSStyle.progress.style = $Saved
            }
            else {
                $host.privateData.ProgressBackgroundColor = $saved
            }
        }
    } #end

}
