

#a class definition for the myTimer commands
Class MyTimer {
    [string]$Name
    [datetime]$Start
    [datetime]$End
    [timespan]$Duration
    [boolean]$Running
    [string]$Description

    [void]StopTimer() {
        $this.End = Get-Date
        $this.Duration = $this.end - $this.start
        $this.Running = $False
        $global:mytimercollection["$($this.name)"] = $this
    }

    [timespan]GetStatus () {
        #temporarily set duration
        $current = (Get-Date) - $this.Start
        return $current
    }

    MyTimer([string]$Name, [string]$Description) {

        Try {
            Get-Variable myTimerCollection -Scope global -ErrorAction Stop | Out-Null
        }
        Catch {
            Write-Verbose "Creating myTimerCollection hashtable"
            New-Variable -Scope global -Name myTimerCollection -value @{}
        }

        #timer names must be unique
        if ($global:myTimerCollection.ContainsKey($Name)) {
            Throw "A timer with the name $name already exists. Please remove it first or create a timer with a new name."
        }
        else {
            Write-Verbose "Creating a myTimer object by name: $name"
            $this.Name = $Name
            $this.Start = Get-Date
            $this.Running = $True
            $this.Description = $Description

            Write-Verbose "Adding new timer $($this.name)"
            $global:mytimercollection.add($this.name, $this)
        }
    }

    #used for importing
    MyTimer([string]$Name, [datetime]$Start, [datetime]$End, [timespan]$Duration, [boolean]$Running, [string]$Description) {
        $this.Name = $Name
        $this.start = $Start
        $this.end = $End
        $this.Duration = $Duration
        $this.running = $Running
        $this.Description = $Description

        Try {
            Get-Variable myTimerCollection -Scope global -ErrorAction Stop | Out-Null
        }
        Catch {
            New-Variable -Scope global -Name myTimerCollection -value @{}
        }
        #reuse existing timers if found
        if ($global:mytimercollection.ContainsKey($this.name)) {
            $global:mytimercollection[$this.name] = $this
        }
        else {
            $global:mytimercollection.add($this.name, $this)
        }
    }
}

<#
Start-PSCountdown is inspired from code originally published at:
https://github.com/Windos/powershell-depot/blob/master/livecoding.tv/StreamCountdown/StreamCountdown.psm1

This should work in Windows PowerShell and PowerShell Core, although not in VS Code.
The ProgressStyle parameter is dynamic and only appears if you are running the command in a Windows console.
#>
Function Start-PSCountdown {
    [cmdletbinding(DefaultParameterSetName = "minutes")]
    [OutputType("None")]
    [Alias("spsc")]

    Param(
        [Parameter(Position = 0, HelpMessage = "Enter the number of minutes to countdown (1-60). The default is 5.", ParameterSetName = "minutes")]
        [ValidateRange(1, 60)]
        [int32]$Minutes = 5,
        [Parameter(Position = 0, ParameterSetname = "time", HelpMessage = "Enter a datetime value as the countdown target.")]
        [DateTime]$Time,
        [Parameter(HelpMessage = "Enter the text for the progress bar title.")]
        [ValidateNotNullorEmpty()]
        [string]$Title = "Counting Down ",
        [Parameter(Position = 1, HelpMessage = "Enter a primary message to display in the parent window.")]
        [ValidateNotNullorEmpty()]
        [string]$Message = "Starting soon.",
        [Parameter(HelpMessage = "Use this parameter to clear the screen prior to starting the countdown.")]
        [alias("cls")]
        [switch]$ClearHost,
        [Parameter(HelpMessage = "The path to a text list of pseudo-tasks")]
        [ValidateNotNullOrEmpty()]
        [string]$Path = "$PSScriptRoot\PSCountdownTasks.txt"
    )
    DynamicParam {
        #this doesn't appear to work in PowerShell core on Linux
        if ($host.privatedata.ProgressBackgroundColor -And ( $PSVersionTable.Platform -eq 'Win32NT' -OR $PSEdition -eq 'Desktop')) {

            #define a parameter attribute object
            $attributes = New-Object System.Management.Automation.ParameterAttribute
            $attributes.ValueFromPipelineByPropertyName = $False
            $attributes.Mandatory = $false
            $attributes.HelpMessage = @"
Select a progress bar style. This only applies when using the PowerShell console or ISE.

Default - use the current value of `$host.privatedata.ProgressBarBackgroundColor
Transparent - set the progress bar background color to the same as the console
Random - randomly cycle through a list of console colors
"@

            #define a collection for attributes
            $attributeCollection = New-Object -Type System.Collections.ObjectModel.Collection[System.Attribute]
            $attributeCollection.Add($attributes)
            #define the validate set attribute
            $validate = [System.Management.Automation.ValidateSetAttribute]::new("Default", "Random", "Transparent")
            $attributeCollection.Add($validate)

            #add an alias
            $alias = [System.Management.Automation.AliasAttribute]::new("style")
            $attributeCollection.Add($alias)

            #define the dynamic param
            $dynParam1 = New-Object -Type System.Management.Automation.RuntimeDefinedParameter("ProgressStyle", [string], $attributeCollection)
            $dynParam1.Value = "Default"

            #create array of dynamic parameters
            $paramDictionary = New-Object -Type System.Management.Automation.RuntimeDefinedParameterDictionary
            $paramDictionary.Add("ProgressStyle", $dynParam1)
            #use the array
            return $paramDictionary

        } #if
    } #dynamic parameter
    Begin {
        Write-Verbose "Starting $($myinvocation.MyCommand)"
        $PSBoundParameters | Out-String | Write-Verbose

        if ($psboundparameters.ContainsKey('progressStyle')) {

            if ($PSBoundParameters.Item('ProgressStyle') -ne 'default') {
                $saved = $host.privateData.ProgressBackgroundColor
            }
            if ($PSBoundParameters.Item('ProgressStyle') -eq 'transparent') {
                $host.privateData.progressBackgroundColor = $host.ui.RawUI.BackgroundColor
            }
        }
        Write-Verbose "Using parameter set $($pscmdlet.ParameterSetName)"

        if (Test-Path $Path) {
            #import entries from list without a # comment and trim each one
            Write-verbose "Loading task messages from $path"
            $loading = Get-Content -path $Path |
                Where-Object {$_ -match "\w+" -AND $_ -notmatch '#'} | foreach-object {$_.Trim()}
        }
        else {
            Write-Verbose "$Path not found. Using default values."
            $loading = "Warming up the room", "Charging batteries", "Formatting C:"
        }
        if ($ClearHost) {
            Clear-Host
        }
        $startTime = Get-Date
        if ($pscmdlet.ParameterSetName -eq 'minutes') {
            Write-verbose "Adding $minutes minutes to start time"
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
        $progcolors = "black", "darkgreen", "magenta", "blue", "darkgray"

    } #begin
    Process {
        #this does not work in VS Code
        if ($host.name -match 'Visual Studio Code') {
            Write-Warning "This command will not work in the integrated PowerShell Conole in VS Code."
            #bail out
            Return
        }
        Do {
            $now = Get-Date
            $secondsElapsed = (New-TimeSpan -Start $startTime -End $now).TotalSeconds
            $secondsRemaining = $totalSeconds - $secondsElapsed
            $percentDone = ($secondsElapsed / $totalSeconds) * 100

            Write-Progress -id 0 -Activity $Title -Status $Message -PercentComplete $percentDone -SecondsRemaining $secondsRemaining

            $secondsElapsedChild = (New-TimeSpan -Start $startTimeChild -End $now).TotalSeconds
            $secondsRemainingChild = $totalSecondsChild - $secondsElapsedChild
            $percentDoneChild = ($secondsElapsedChild / $totalSecondsChild) * 100

            if ($percentDoneChild -le 100) {
                Write-Progress -id 1 -ParentId 0 -Activity $loadingMessage -PercentComplete $percentDoneChild -SecondsRemaining $secondsRemainingChild
            }

            if ($percentDoneChild -ge 100 -and $percentDone -le 98) {
                if ($PSBoundParameters.ContainsKey('ProgressStyle') -AND $PSBoundParameters.Item('ProgressStyle') -eq 'random') {
                    $host.privateData.progressBackgroundColor = ($progcolors | Get-Random)
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
            $host.privateData.ProgressBackgroundColor = $saved
        }
    } #end

} #close Start-PSCountdown

Function Start-PSTimer {

    [cmdletbinding()]
    [OutputType("None", "PSObject")]
    [Alias("spst")]

    Param(
        [Parameter(Position = 0, HelpMessage = "Enter seconds to countdown from")]
        [Int]$Seconds = 10,
        [Parameter(Position = 1, HelpMessage = "Enter a scriptblock to execute at the end of the countdown")]
        [alias("globalblock", "sb")]
        [scriptblock]$Scriptblock,
        [Switch]$ProgressBar,
        [string]$Title = "Countdown",
        [Switch]$Clear,
        [String]$Message
    )

    #save beginning value for total seconds
    $TotalSeconds = $Seconds

    If ($clear) {
        Clear-Host
    }

    #get current cursor position
    $Coordinate = New-Object System.Management.Automation.Host.Coordinates
    $Coordinate.X = $host.ui.rawui.CursorPosition.X
    $Coordinate.Y = $host.ui.rawui.CursorPosition.Y
    #define the Escape key
    $ESCKey = 27

    #define a variable indicating if the user aborted the countdown
    $Abort = $False

    while ($seconds -ge 1) {

        if ($host.ui.RawUi.KeyAvailable) {
            $key = $host.ui.RawUI.ReadKey("NoEcho,IncludeKeyUp,IncludeKeyDown")

            if ($key.VirtualKeyCode -eq $ESCkey) {
                #ESC was pressed so quit the countdown and set abort flag to True
                $Seconds = 0
                $Abort = $True
            }
        }
        if ($Clear) {
            Clear-Host
        }
        If ($ProgressBar) {
            #calculate percent time remaining, but in reverse so the progress bar
            #moves from left to right
            $percent = 100 - ($seconds / $TotalSeconds) * 100
            Write-Progress -Activity $Title -SecondsRemaining $Seconds -Status "Time Remaining" -PercentComplete $percent
            Start-Sleep -Seconds 1
        }
        Else {

            $host.ui.rawui.CursorPosition = $Coordinate
            #write the seconds with padded trailing spaces to overwrite any extra digits such
            #as moving from 10 to 9
            $pad = ($TotalSeconds -as [string]).Length
            if ($seconds -le 10) {
                $color = "Red"
            }
            else {
                $color = "Green"
            }
            $msg = @"
$Title
$(([string]$Seconds).Padright($pad))
"@

            write-host $msg -ForegroundColor $color

            Start-Sleep -Seconds 1
        }
        #decrement $Seconds
        $Seconds--
    } #while

    if ($Progress) {
        #set progress to complete
        Write-Progress -Completed
    }

    if (-Not $Abort) {

        if ($clear) {
            #if $Clear was used, center the message in the console
            $Coordinate.X = $Coordinate.X - ([int]($message.Length) / 2)
        }

        $host.ui.rawui.CursorPosition = $Coordinate

        Write-Host $Message -ForegroundColor Green
        #run the scriptblock if specified
        if ($scriptblock) {
            Invoke-Command -ScriptBlock $scriptblock
        }
    }
    else {
        Write-Warning "Countdown aborted"
    }

} #close Start-PSTimer
Function Start-MyTimer {

    [cmdletbinding()]
    [OutputType([MyTimer])]
    [Alias("ton")]

    Param(
        [Parameter(Position = 0)]
        [ValidateNotNullorEmpty()]
        [string[]]$Name = "MyTimer",
        [string]$Description
    )

    Write-Verbose "Starting: $($MyInvocation.Mycommand)"
    #display PSBoundparameters formatted nicely for Verbose output
    [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
    Write-Verbose "PSBoundparameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n"
    foreach ($timer in $Name) {

        Try {
            Write-Verbose "Creating timer $timer"
            New-Object -TypeName MyTimer -ArgumentList $timer, $Description -ErrorAction stop
        }
        Catch {
            # Write-Warning "Failed to create timer $timer. $($_.exception.message)"
            Throw $_
        }

    } #foreach

    Write-Verbose "Ending: $($MyInvocation.Mycommand)"

} #Start-MyTimer
Function Remove-MyTimer {

    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("None")]
    Param(
        [Parameter(Position = 0, Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullorEmpty()]
        [string[]]$Name
    )
    Begin {
        Write-Verbose "Starting: $($MyInvocation.Mycommand)"
    }   #begin
    Process {
        #display PSBoundparameters formatted nicely for Verbose output
        [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
        Write-Verbose "PSBoundparameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n"
        foreach ($timer in $Name) {
            Try {
                if ($PSCmdlet.ShouldProcess($timer)) {
                    Write-Verbose "Removing timer $timer"
                    if ($global:mytimercollection.ContainsKey("$timer")) {
                        $global:mytimercollection.remove("$timer")
                    }
                    else {
                        Write-Warning "Can't find a timer with the name $timer"
                    }
                }
            }
            Catch {
                Write-Warning "Failed to remove timer $timer. $($_.exception.message)"
            }
        } #foreach
    } #process
    End {
        Write-Verbose "Ending: $($MyInvocation.Mycommand)"
    } #end
} #Remove-MyTimer
Function Stop-MyTimer {

    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("MyTimer")]
    [Alias("toff")]

    Param(
        [Parameter(Position = 0, Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullorEmpty()]
        [string]$Name
    )
    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
        #display PSBoundparameters formatted nicely for Verbose output
        [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
        Write-Verbose "[BEGIN  ] PSBoundparameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n"

    }
    Process {
        Write-Verbose "[PROCESS] Getting timer $name"
        $timers = ($global:myTimerCollection).Values.where( {$_.name -like $name})
        if ($timers) {
            Foreach ($timer in $timers) {
                write-verbose "[PROCESS] Processing $( $timer | Out-string)"
                if ($timer.running) {
                    if ($PSCmdlet.ShouldProcess($timer.name)) {
                        $timer.stopTimer()

                        Get-MyTimer -name $timer.name | Select-Object -Property History

                    } #should process
                }
                else {
                    write-warning "$($timer.name) is not running"
                }
            }
        }
        else {
            Write-Warning "Can't find a timer called $Name. You need to start the timer first."
        }
    }
    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    }
} #Stop-MyTimer

Function Get-MyTimer {

    [cmdletbinding()]
    [OutputType([MyTimer[]])]
    Param(
        [Parameter(Position = 0, ValueFromPipelineByPropertyName)]
        [ValidateNotNullorEmpty()]
        [string[]]$Name
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
    } #begin

    Process {
        #display PSBoundparameters formatted nicely for Verbose output
        [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
        Write-Verbose "[PROCESS] PSBoundparameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n"

        if ($Name) {
            Write-Verbose "[PROCESS] Getting timer $Name"
            $timers = foreach ($item in $Name) {
                ($global:MytimerCollection).Values.where( {$_.name -like $item})
            }
        }
        else {
            #find all running timers by default
            Write-Verbose "[PROCESS] Getting all timers"
            $timers = $global:myTimerCollection.Values
        }

        Write-Verbose "[PROCESS] Getting current timer status"
        if ($timers.count -ge 1) {
            foreach ($timer in ($timers | Sort-Object -Property Start)) {
                if ($timer.running) {
                    #set the duration to the current value
                    $timer.duration = $timer.Getstatus()
                    $timer
                    #set duration back to 0
                    $timer.duration = 0
                }
                else {
                    #update Duration value if timer is stopped and it hasn't been updated
                    if ($timer.duration.seconds -eq 0) {
                        write-Verbose "Correcting duration on $($timer.name)"
                        $timer.Duration = $timer.end - $timer.start
                    }
                    $timer
                }

            }#foreach
        } #if $timers
        else {
            if ($name) {
                $warn = "Can't find any matching timer objects with the name $Name."
            }
            else {
                $warn = "No defined timers found. Use Start-MyTimer to create one."
            }
            Write-Warning $warn
        }
    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    }
} #Get-MyTimer

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
} #Set-MyTimer

Function Export-MyTimer {

    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("None")]
    Param(
        [Parameter(Position = 0)]
        [string]$Name,

        [Parameter(
            Mandatory,
            HelpMessage = "Enter the name and path of an XML file"
        )]
        [ValidateNotNullorEmpty()]
        [string]$Path
    )

    Write-Verbose "Starting: $($MyInvocation.Mycommand)"
    #display PSBoundparameters formatted nicely for Verbose output
    [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
    Write-Verbose "PSBoundparameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n"

    if ($Name) {
        Write-Verbose "Finding timer variable $Name"
        $found = $global:mytimercollection["$name"]
    }
    else {
        Write-Verbose "Finding all timer variables"
        $found = $global:mytimercollection.values
    }

    If ($found) {
        Try {
            Write-Verbose "Exporting timers to $Path"
            $found | Export-Clixml -Path $path -ErrorAction Stop
        }
        Catch {
            Write-Error $_
        }
    }
    else {
        Write-Warning "No matching timers found."
    }

    Write-Verbose "Ending: $($MyInvocation.Mycommand)"
} #Export-MyTimer

Function Import-MyTimer {

    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("MyTimer[]")]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = "Enter the name and path of an XML file"
        )]
        [ValidateNotNullorEmpty()]
        [ValidateScript( {
                if (Test-Path $_) {
                    $True
                }
                else {
                    Throw "Cannot validate path $_"
                }
            })]
        [string]$Path
    )

    Write-Verbose "Starting: $($MyInvocation.Mycommand)"
    #display PSBoundparameters formatted nicely for Verbose output
    [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
    Write-Verbose "PSBoundparameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n"

    Import-Clixml -Path $Path | foreach-object {
        if ($PSCmdlet.ShouldProcess($_.name)) {
            Write-Verbose "Importing $($_.name)"
            New-Object -TypeName MyTimer -ArgumentList $_.name, $_.start, $_.end, $_.duration, $_.running, $_.description | Out-Null
            Get-Mytimer -name $_.name
        }
    }

    Write-Verbose "Ending: $($MyInvocation.Mycommand)"
} #Import-MyTimer

Function Get-HistoryRuntime {

    [cmdletbinding(DefaultParameterSetName = "ID")]
    [OutputType([PSCustomObject])]
    [Alias("ghr")]

    Param(
        [Parameter(
            Position = 0,
            HelpMessage = "Enter a history item ID",
            ParameterSetName = "ID"
        )]
        [int]$ID = (Get-History -count 1).ID,
        [Parameter(ValueFromPipeline, ParameterSetName = "History")]
        [Microsoft.PowerShell.Commands.HistoryInfo]$History,
        [Switch]$Detail
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
        Write-Verbose "[BEGIN  ] Using parameter set $($PSCmdlet.parameterSetName)"
    } #begin

    Process {

        Try {
            If ($PSCmdlet.ParameterSetName -eq "ID") {
                $History = Get-History -Id $ID -ErrorAction Stop
            }
            Write-Verbose "[PROCESS] Calculating runtime for id $($history.ID)"

            $propHash = [Ordered]@{
                ID      = $history.ID
                RunTime = $history.EndExecutionTime - $history.StartExecutionTime
            }

            if ($Detail) {
                Write-Verbose "[PROCESS] Adding history detail"
                $prophash.Add("Status", $History.ExecutionStatus)
                $propHash.Add("Command", $History.CommandLine)
            }
            #create an object
            New-Object -TypeName PSObject -Property $propHash

        } #Try
        Catch {
            Write-Warning "Failed to find history with an ID of $ID"
        }

    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    } #end

} #close function

