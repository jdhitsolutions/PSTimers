#requires -version 5.1

#TODO: Add WPF timer

#region Main

<#
Inspired from code originally published at: 
https://github.com/Windos/powershell-depot/blob/master/livecoding.tv/StreamCountdown/StreamCountdown.psm1

This should work in Windows PowerShell and PowerShell Core, although not in VS Code.
The ProgressStyle parameter is dynamic and only appears if you are running the command in a Windows console.
#>

Function Start-PSCountdown {
    [cmdletbinding(DefaultParameterSetName = "minutes")]
    [OutputType("None")]
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
        [switch]$ClearHost,
        [Parameter(HelpMessage = "The path to a text list of pseudo-tasks")]
        [ValidateNotNullOrEmpty()]
        [string]$Path = "$PSScriptRoot\PSCountdownTasks.txt"
    )
    DynamicParam {
        #this doesn't appear to work in PowerShell core on Linux
        if ($host.PrivateData.ProgressBackgroundColor -And ( $PSVersionTable.Platform -eq 'Win32NT' -OR $PSEdition -eq 'Desktop')) {
    
            #define a parameter attribute object
            $attributes = New-Object System.Management.Automation.ParameterAttribute
            $attributes.ValueFromPipelineByPropertyName = $False
            $attributes.Mandatory = $false
            $attributes.HelpMessage = @"
Select a progress bar style. This only applies when using the PowerShell console or ISE.           

Default - use the current value of `$host.PrivateData.ProgressBarBackgroundColor
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
                $saved = $host.PrivateData.ProgressBackgroundColor 
            }
            if ($PSBoundParameters.Item('ProgressStyle') -eq 'transparent') {
                $host.PrivateData.progressBackgroundColor = $host.ui.RawUI.BackgroundColor
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
                    $host.PrivateData.progressBackgroundColor = ($progcolors | Get-Random)
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
            $host.PrivateData.ProgressBackgroundColor = $saved
        }
    } #end

} #close Start-PSCountdown

 
Function Start-PSTimer {
    
[cmdletbinding()]
[OutputType("None","Results from specified scriptblock")]
    Param(
        [Parameter(Position = 0, HelpMessage = "Enter seconds to countdown from")]
        [Int]$Seconds = 10,
        [Parameter(Position = 1, HelpMessage = "Enter a scriptblock to execute at the end of the countdown")]
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
            Invoke-Command -ScriptBlock $Scriptblock
        }
    }
    else {
        Write-Warning "Countdown aborted"
    }
    
} #close Start-PSTimer
Function Start-MyTimer {

    [cmdletbinding()]
    [OutputType("None","[System.Management.Automation.PSVariable] when using -Passthru")]
    Param(
    [Parameter(Position = 0)]
    [ValidateNotNullorEmpty()]
    [string[]]$Name = "MyTimer",
    [switch]$Passthru
    )
    
    Write-Verbose "Starting: $($MyInvocation.Mycommand)"
    #display PSBoundparameters formatted nicely for Verbose output  
    [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
    Write-Verbose "PSBoundparameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n" 
    
    $newParams = @{
        Name = $null
        Value = $null
        Scope = 'Global' 
        Option = 'ReadOnly'
        ErrorAction = 'Stop'           
    }
    
    If ($Passthru) {
        $newParams.Add("Passthru",$True)
    }
    
    foreach ($timer in $Name) {
        #set a global variable
        $newParams.Name = $timer
        $newParams.Value = (Get-Date)    
    
        Try {
            Write-Verbose "Creating timer $timer"
            New-Variable @newParams
    
        }
        Catch {
            Write-Warning "Failed to create timer $timer. $($_.exception.message)"
        }
    } #foreach
    
    Write-Verbose "Ending: $($MyInvocation.Mycommand)"
    
    } #Start-MyTimer
    
    Function Stop-MyTimer {
    
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType([system.timespan],[system.string])]
    Param(
    [Parameter(Position = 0)]
    [ValidateNotNullorEmpty()]
    [string[]]$Name = "MyTimer",
    [switch]$AsString
    )
    
    Write-Verbose "Starting: $($MyInvocation.Mycommand)"
    #display PSBoundparameters formatted nicely for Verbose output  
    [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
    Write-Verbose "PSBoundparameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n" 
    
    If (Test-Path -Path variable:$Name) {
                
        Write-Verbose "Calculating timespan"
        $elapsed = (Get-Date) - (Get-Variable -Name $Name).Value
        if ($AsString) {
            Write-Verbose "Writing result as a string"
            $elapsed.ToString()
        }
        else {
            $elapsed
        }
        Write-Verbose "Removing timer $Name"
        Remove-Variable -Name $Name -Scope Global -Force
    }
    else {
        Write-Warning "Can't find a timer called $Name. You need to start the timer first."
    }
    
    Write-Verbose "Ending: $($MyInvocation.Mycommand)"
    } #Stop-MyTimer
    
    Function Get-MyTimer {
    
    [cmdletbinding()]
    [OutputType([PSCustomObject[]])]
    Param(
    [Parameter(Position = 0,
    ValueFromPipelineByPropertyName
    )]
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
    
    if (-Not $Name) {
        #find all timers if no name specified
        $name = (Find-myTimer).Name
    }
    foreach ($timer in $Name) {
        If (Test-Path -Path variable:$timer) {
            Write-Verbose "[PROCESS] Getting current timer status"
            $var = Get-Variable -Name $timer
            $var | Select-Object -property Name,@{Name="Started";Expression = { $_.value}},
            @{Name="Elapsed";Expression = { ((Get-Date) - $var.value) }}
    
        }
        else {
            Write-Warning "Can't find a timer with the name $timer"
        }
    } #foreach
    
    } #process
    
    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    }
    } #Get-MyTimer
    
    Function Find-MyTimer {
    
    [cmdletbinding()]
    [OutputType([system.string[]])]
    Param()
    
    Write-Verbose "Starting: $($MyInvocation.Mycommand)"
    
    (Get-Variable).where({$_.value -is [datetime] -AND $_.options -eq 'ReadOnly'}) | Select-Object -property Name
    
    Write-Verbose "Ending: $($MyInvocation.Mycommand)"
    } #Find-MyTimer
    
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
        $found = (Find-MyTimer).Where({$_.name -eq $Name})
    }
    else {
        Write-Verbose "Finding all timer variables"
        $found = Find-MyTimer
    }
    
    If ($found) {
        Try {
            $found | Get-Variable | Select-Object -Property Name,Value,Options | 
            Export-Clixml -Path $path -ErrorAction Stop
        }
        Catch {
            Write-Error $_
        }
    }
    else {
        Write-Warning "No matching timer variables found."
    }
    
    Write-Verbose "Ending: $($MyInvocation.Mycommand)"
    } #Export-MyTimer
    
    Function Import-MyTimer {
    
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType([System.Management.Automation.PSVariable])]
    Param(
    [Parameter(
    Position = 0,
    Mandatory,
    HelpMessage = "Enter the name and path of an XML file"
    )]
    [ValidateNotNullorEmpty()]
    [ValidateScript({
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
        Write-Verbose "Importing $($_.name)"
        New-Variable -Name $_.name -Value $_.value -force -Option ReadOnly -scope Global
    }
    
    Write-Verbose "Ending: $($MyInvocation.Mycommand)"
    } #Import-MyTimer
    

#endregion

#region define aliases
$aliases=@()
$aliases+= Set-Alias -Name ton -Value Start-MyTimer -PassThru 
$aliases+= Set-Alias -Name toff -Value Stop-MyTimer -PassThru
$aliases+= Set-Alias -Name spsc -Value Start-PSCountdown -PassThru
$aliases+= Set-Alias -Name spst -Value Start-PSTimer -PassThru
#endregion

#region export members
$functions = @('Start-PSCountdown', 'Start-PSTimer','Get-MyTimer', 'Start-MyTimer', 'Stop-MyTimer', 'Find-MyTimer',
'Export-MyTimer','Import-MyTimer')

Export-ModuleMember -Function $functions -Alias $aliases.Name
#endregion