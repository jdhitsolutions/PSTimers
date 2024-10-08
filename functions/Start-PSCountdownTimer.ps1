Function Start-PSCountdownTimer {
    [CmdletBinding(DefaultParameterSetName = "seconds")]
    [OutputType("None")]
    Param(
        [Parameter(
            Position = 0,
            HelpMessage = "Enter seconds to countdown between 10 and 3600. The default is 60.",
            ParameterSetName="seconds"
        )]
        [ValidateRange(10,3600)]
        [Int]$Seconds = 60,

        [Parameter(
            Position = 0,
            Mandatory,
            ParameterSetName = "time",
            HelpMessage = "Enter a DateTime value as the countdown target."
        )]
        [ValidateNotNullOrEmpty()]
        #validate that the time is in the future
        [ValidateScript({ $_ -gt (Get-Date) })]
        [DateTime]$Time,

        [Parameter(HelpMessage = "Specify a short message prefix like 'Starting in: '")]
        [VaLidateNotNullOrEmpty()]
        [String]$Message,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateScript({ $_ -gt 8 })]
        [alias("size")]
        [Int]$FontSize = 48,

        [Parameter(HelpMessage = "Specify a font style.", ValueFromPipelineByPropertyName)]
        [ValidateSet("Normal", "Italic", "Oblique")]
        [alias("style")]
        [String]$FontStyle = "Normal",

        [Parameter(HelpMessage = "Specify a font weight.", ValueFromPipelineByPropertyName)]
        [ValidateSet("Normal", "Bold", "Light")]
        [alias("weight")]
        [String]$FontWeight = "Normal",

        [Parameter(HelpMessage = "Specify a font color like Green or an HTML code like '#FF1257EA'", ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [String]$Color = "White",

        [Parameter(HelpMessage = "Specify a font family.", ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [alias("family")]
        [String]$FontFamily = "Segoi UI",

        [Parameter(HelpMessage = "Do you want the clock to always be on top?", ValueFromPipelineByPropertyName)]
        [Switch]$OnTop,

        [Parameter(HelpMessage = "Specify the clock position as an array of left and top values.", ValueFromPipelineByPropertyName)]
        [ValidateCount(2, 2)]
        [Int32[]]$Position,

        [Parameter(HelpMessage = "Specify the number of seconds remaining to switch to alert coloring")]
        [ValidateScript({$_ -ge 1})]
        [Int]$Alert = 50,

        [Parameter(HelpMessage = "Specify alert coloring")]
        [ValidateNotNullOrEmpty()]
        [String]$AlertColor = "Yellow",

        [Parameter(HelpMessage = "Specify the number of seconds remaining to switch to warning coloring")]
        [ValidateScript({$_ -ge 1})]
        [Int]$Warning = 30,

        [Parameter(HelpMessage = "Specify warning coloring")]
        [ValidateNotNullOrEmpty()]
        [String]$WarningColor = "Red",

        [Parameter(HelpMessage = "Define a ScriptBlock to execute when the clock expires")]
        [ValidateNotNullOrEmpty()]
        [ScriptBlock]$Action
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
    } #begin
    Process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Using parameter set $($psCmdlet.ParameterSetName)"
        if ($psCmdlet.ParameterSetName -eq 'time') {
            $Seconds = ($Time - (Get-Date)).TotalSeconds
        }
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Using PSBoundParameters: `n $(New-Object PSObject -Property $PSBoundParameters | Out-String)"
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Validating"
        if ($IsLinux -OR $isMacOS) {
            Write-Warning "This command requires a Windows platform."
            return
        }

        if ($global:PSCountdownClock.Running) {
            Write-Warning "You already have a clock running. You can only have one clock running at a time."
            $PSCountdownClock
            Return
        }

        if (Test-Path $env:temp\pscountdown-flag.txt) {
            $msg = @"

A running countdown clock has been detected from another PowerShell session:

$(Get-Content $env:temp\pscountdown-flag.txt)

If this is incorrect, delete $env:temp\pscountdown-flag.txt and try again.

"@
            Write-Warning $msg
            $r = Read-Host "Do you want to remove the flag file? Y/N"
            if ($r -eq 'Y') {
                Remove-Item $env:temp\pscountdown-flag.txt
            }
            else {
                #bail out
                Return
            }
        }

        #verify the DateTime format
        Try {
            [void](Get-Date -Format $DateFormat -ErrorAction Stop)
        }
        Catch {
            Write-Warning "The DateFormat value $DateFormat is not a valid format string. Try something like F,G, or U which are case-sensitive."
            Return
        }

        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Building a synchronized hashtable (`$PSCountDownClock)"
        $global:PSCountdownClock = [hashtable]::Synchronized(@{
                FontSize         = $FontSize
                FontStyle        = $FontStyle
                FontWeight       = $FontWeight
                Color            = $Color
                FontFamily       = $FontFamily
                OnTop            = $OnTop
                StartingPosition = $Position
                CurrentPosition  = $Null
                Seconds          = $seconds
                Message          = $Message
                Alert            = $alert
                Warning          = $Warning
                AlertColor       = $AlertColor
                WarningColor     = $WarningColor
                Action           = $Action
            })
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] $($global:PSCountdownClock | Out-String)"
        #Run the clock in a RunSpace
        $rs = [RunSpaceFactory]::CreateRunSpace()
        $rs.ApartmentState = "STA"
        $rs.ThreadOptions = "ReuseThread"
        $rs.Open()

        $global:PSCountdownClock.add("RunSpace", $rs)

        $rs.SessionStateProxy.SetVariable("PSCountdownClock", $global:PSCountdownClock)

        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Defining the RunSpace command"
        $psCmd = [PowerShell]::Create().AddScript({

                Add-Type -AssemblyName PresentationFramework -ErrorAction Stop
                Add-Type -AssemblyName PresentationCore -ErrorAction Stop
                Add-Type -AssemblyName WindowsBase -ErrorAction Stop

                # a private function to stop the clock and clean up
                Function _QuitClock {
                    $PSCountdownClock.Running = $False
                    $timer.stop()
                    $timer.IsEnabled = $False
                    $form.close()

                    #define a thread job to clean up the RunSpace
                    $cmd = {
                        Param([Int]$ID)
                        $r = Get-RunSpace -Id $id
                        $r.close()
                        $r.dispose()
                    }
                    Start-ThreadJob -ScriptBlock $cmd -ArgumentList $PSCountdownClock.RunSpace.id

                    #delete the flag file
                    if (Test-Path $env:temp\pscountdown-flag.txt) {
                        Remove-Item $env:temp\pscountdown-flag.txt
                    }

                    #Start the Action if specified
                    If ($PSCountdownClock.Action) {
                        Invoke-Command -ScriptBlock $PSCountdownClock.Action
                    }
                }

                $form = New-Object System.Windows.Window
                [Int]$script:i = $PSCountdownClock.seconds
                <#
                some of the form settings are irrelevant because it is transparent
                but leaving them in the event I need to turn off transparency
                to debug or troubleshoot
                #>

                $form.Title = "PSCountdownClock"
                $form.Height = 200
                $form.Width = 400
                $form.SizeToContent = "WidthAndHeight"
                $form.AllowsTransparency = $True
                $form.Topmost = $PSCountdownClock.OnTop

                $form.Background = "Transparent"
                $form.BorderThickness = "1,1,1,1"
                $form.VerticalAlignment = "top"

                if ($PSCountdownClock.StartingPosition) {
                    $form.left = $PSCountdownClock.StartingPosition[0]
                    $form.top = $PSCountdownClock.StartingPosition[1]
                }
                else {
                    $form.WindowStartupLocation = "CenterScreen"
                }
                $form.WindowStyle = "None"
                $form.ShowInTaskbar = $False

                #define events
                #call the private function to stop the clock and clean up
                $form.Add_MouseRightButtonUp({ _QuitClock })

                $form.Add_MouseLeftButtonDown({ $form.DragMove() })

                #press + to increase the size and - to decrease
                #the clock needs to refresh to see the result
                $form.Add_KeyDown({
                    switch ($_.key) {
                        { 'Add', 'OemPlus' -contains $_ } {
                            If ( $PSCountdownClock.fontSize -ge 8) {
                                $PSCountdownClock.fontSize++
                                $form.UpdateLayout()
                            }
                        }
                        { 'Subtract', 'OemMinus' -contains $_ } {
                            If ($PSCountdownClock.FontSize -ge 8) {
                                $PSCountdownClock.FontSize--
                                $form.UpdateLayout()
                            }
                        }
                    }
                })

                #fail safe to remove flag file
                $form.Add_Unloaded({
                    if (Test-Path $env:temp\pscountdown-flag.txt) {
                        Remove-Item $env:temp\pscountdown-flag.txt
                    }
                })

                $stack = New-Object System.Windows.Controls.StackPanel

                $label = New-Object System.Windows.Controls.label
                $ts = "{0} {1}" -f $PSCountdownClock.message,(New-TimeSpan -Seconds $script:i).ToString()
                $label.Content = $ts.Trim()
                #"Hello World"
                #Get-Date -Format $PSCountdownClock.DateFormat

                $label.HorizontalContentAlignment = "Center"
                $label.Foreground = $PSCountdownClock.Color
                $label.FontStyle = $PSCountdownClock.FontStyle
                $label.FontWeight = $PSCountdownClock.FontWeight
                $label.FontSize = $PSCountdownClock.FontSize
                $label.FontFamily = $PSCountdownClock.FontFamily

                $label.VerticalAlignment = "Top"

                $stack.AddChild($label)
                $form.AddChild($stack)

                $timer = New-Object System.Windows.Threading.DispatcherTimer
                $timer.Interval = [TimeSpan]"0:0:1.00"
                $timer.Add_Tick({
                        $script:i--
                        if ($PSCountdownClock.Running -AND ($script:i -gt 0)) {
                            #set the font to yellow at 20 seconds and red at 10 seconds
                            if ($script:i -le $PSCountdownClock.Warning) {
                                $label.Foreground = $PSCountdownClock.WarningColor
                            }
                            elseif ($script:i -le $PSCountdownClock.Alert) {
                                $label.foreground = $PSCountdownClock.AlertColor
                            }
                            else {
                                $label.Foreground = $PSCountdownClock.Color
                            }
                            $label.FontStyle = $PSCountdownClock.FontStyle
                            $label.FontWeight = $PSCountdownClock.FontWeight
                            $label.FontSize = $PSCountdownClock.FontSize
                            $label.FontFamily = $PSCountdownClock.FontFamily
                            $ts = "{0} {1}" -f $PSCountdownClock.message,(New-TimeSpan -Seconds $script:i).ToString()
                            $label.Content = $ts.Trim()
                            #"Hello World"
                            #Get-Date -Format $PSCountdownClock.DateFormat

                            $form.TopMost = $PSCountdownClock.OnTop
                            $form.UpdateLayout()

                            #$PSCountdownClock.Window = $Form
                            $PSCountdownClock.CurrentPosition = $form.left, $form.top
                        }
                        else {
                            _QuitClock
                        }
                    })
                $timer.Start()

                $PSCountdownClock.Running = $True
                $PSCountdownClock.Started = Get-Date

                #Show the clock form
                [void]$form.ShowDialog()
            })

        $psCmd.RunSpace = $rs
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Launching the RunSpace"
        [void]$psCmd.BeginInvoke()

        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Creating the flag file $env:temp\pscountdown-flag.txt"
        "[{0}] PSClock started by {1} under PowerShell process id $pid" -f (Get-Date), $env:USERNAME |
        Out-File -FilePath $env:temp\pscountdown-flag.txt

    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close function
