Function Start-PSCountdownTimer {
    [cmdletbinding()]
    [OutputType("None")]
    Param(

        [Parameter(Position = 0, HelpMessage = "Enter seconds to countdown from")]
        [Int]$Seconds = 60,

        [Parameter(HelpMessage = "Specify a short message prefix like 'Starting in: '")]
        [string]$Message,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateScript({ $_ -gt 8 })]
        [alias("size")]
        [int]$FontSize = 48,

        [Parameter(HelpMessage = "Specify a font style.", ValueFromPipelineByPropertyName)]
        [ValidateSet("Normal", "Italic", "Oblique")]
        [alias("style")]
        [string]$FontStyle = "Normal",

        [Parameter(HelpMessage = "Specify a font weight.", ValueFromPipelineByPropertyName)]
        [ValidateSet("Normal", "Bold", "Light")]
        [alias("weight")]
        [string]$FontWeight = "Normal",

        [Parameter(HelpMessage = "Specify a font color like Green or an HTML code like '#FF1257EA'", ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]$Color = "White",

        [Parameter(HelpMessage = "Specify a font family.", ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [alias("family")]
        [string]$FontFamily = "Segoi UI",

        [Parameter(HelpMessage = "Do you want the clock to always be on top?", ValueFromPipelineByPropertyName)]
        [switch]$OnTop,

        [Parameter(HelpMessage = "Specify the clock position as an array of left and top values.", ValueFromPipelineByPropertyName)]
        [ValidateCount(2, 2)]
        [Int32[]]$Position,

        [Parameter(HelpMessage = "Specify the number of seconds remaining to switch to alert coloring")]
        [ValidateScript({$_ -ge 1})]
        [int]$Alert = 50,

        [Parameter(HelpMessage = "Specify alert coloring")]
        [ValidateNotNullOrEmpty()]
        [string]$AlertColor = "Yellow",

        [Parameter(HelpMessage = "Specify the number of seconds remaining to switch to warning coloring")]
        [ValidateScript({$_ -ge 1})]
        [int]$Warning = 30,

        [Parameter(HelpMessage = "Specify warning coloring")]
        [ValidateNotNullOrEmpty()]
        [string]$WarningColor = "Red"
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
    } #begin
    Process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Validating"
        if ($IsLinux -OR $isMacOS) {
            Write-Warning "This command requires a Windows platform."
            return
        }

        if ($global:PSCountDownClock.Running) {
            Write-Warning "You already have a clock running. You can only have one clock running at a time."
            $PSCountDownClock
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

        #verify the datetime format
        Try {
            [void](Get-Date -Format $DateFormat -ErrorAction Stop)
        }
        Catch {
            Write-Warning "The DateFormat value $DateFormat is not a valid format string. Try something like F,G, or U which are case-sensitive."
            Return
        }

        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Building a synchronized hashtable"
        $global:PSCountDownClock = [hashtable]::Synchronized(@{
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
            })
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] $($global:PSCountDownClock | Out-String)"
        #Run the clock in a runspace
        $rs = [RunspaceFactory]::CreateRunspace()
        $rs.ApartmentState = "STA"
        $rs.ThreadOptions = "ReuseThread"
        $rs.Open()

        $global:PSCountDownClock.add("Runspace", $rs)

        $rs.SessionStateProxy.SetVariable("PSCountDownClock", $global:PSCountDownClock)

        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Defining the runspace command"
        $psCmd = [PowerShell]::Create().AddScript({

                Add-Type -AssemblyName PresentationFramework -ErrorAction Stop
                Add-Type -AssemblyName PresentationCore -ErrorAction Stop
                Add-Type -AssemblyName WindowsBase -ErrorAction Stop

                # a private function to stop the clock and clean up
                Function _QuitClock {
                    $PSCountDownClock.Running = $False
                    $timer.stop()
                    $timer.isenabled = $False
                    $form.close()

                    #define a thread job to clean up the runspace
                    $cmd = {
                        Param([int]$ID)
                        $r = Get-Runspace -Id $id
                        $r.close()
                        $r.dispose()
                    }
                    Start-ThreadJob -ScriptBlock $cmd -ArgumentList $PSCountDownClock.runspace.id

                    #delete the flag file
                    if (Test-Path $env:temp\pscountdown-flag.txt) {
                        Remove-Item $env:temp\pscountdown-flag.txt
                    }
                }

                $form = New-Object System.Windows.Window
                [int]$script:i = $PSCountDownClock.seconds
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
                $form.Topmost = $PSCountDownClock.Ontop

                $form.Background = "Transparent"
                $form.borderthickness = "1,1,1,1"
                $form.VerticalAlignment = "top"

                if ($PSCountDownClock.StartingPosition) {
                    $form.left = $PSCountDownClock.StartingPosition[0]
                    $form.top = $PSCountDownClock.StartingPosition[1]
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
                            If ( $PSCountDownClock.fontSize -ge 8) {
                                $PSCountDownClock.fontSize++
                                $form.UpdateLayout()
                            }
                        }
                        { 'Subtract', 'OemMinus' -contains $_ } {
                            If ($PSCountDownClock.FontSize -ge 8) {
                                $PSCountDownClock.FontSize--
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
                $ts = "{0} {1}" -f $PSCountDownClock.message,(New-TimeSpan -Seconds $script:i).ToString()
                $label.Content = $ts.Trim()
                #"Hello World"
                #Get-Date -Format $PSCountDownClock.DateFormat

                $label.HorizontalContentAlignment = "Center"
                $label.Foreground = $PSCountDownClock.Color
                $label.FontStyle = $PSCountDownClock.FontStyle
                $label.FontWeight = $PSCountDownClock.FontWeight
                $label.FontSize = $PSCountDownClock.FontSize
                $label.FontFamily = $PSCountDownClock.FontFamily

                $label.VerticalAlignment = "Top"

                $stack.AddChild($label)
                $form.AddChild($stack)

                $timer = New-Object System.Windows.Threading.DispatcherTimer
                $timer.Interval = [TimeSpan]"0:0:1.00"
                $timer.Add_Tick({
                        $script:i--
                        if ($PSCountDownClock.Running -AND ($script:i -gt 0)) {
                            #set the font to yellow at 20 seconds and red at 10 seconds
                            if ($script:i -le $PSCountDownClock.Warning) {
                                $label.Foreground = $PSCountDownClock.WarningColor
                            }
                            elseif ($script:i -le $PSCountDownClock.Alert) {
                                $label.foreground = $PSCountDownClock.AlertColor
                            }
                            else {
                                $label.Foreground = $PSCountDownClock.Color
                            }
                            $label.FontStyle = $PSCountDownClock.FontStyle
                            $label.FontWeight = $PSCountDownClock.FontWeight
                            $label.FontSize = $PSCountDownClock.FontSize
                            $label.FontFamily = $PSCountDownClock.FontFamily
                            $ts = "{0} {1}" -f $PSCountDownClock.message,(New-TimeSpan -Seconds $script:i).ToString()
                            $label.Content = $ts.Trim()
                            #"Hello World"
                            #Get-Date -Format $PSCountDownClock.DateFormat

                            $form.TopMost = $PSCountDownClock.OnTop
                            $form.UpdateLayout()

                            #$PSCountDownClock.Window = $Form
                            $PSCountDownClock.CurrentPosition = $form.left, $form.top
                        }
                        else {
                            _QuitClock
                        }
                    })
                $timer.Start()

                $PSCountDownClock.Running = $True
                $PSCountDownClock.Started = Get-Date

                #Show the clock form
                [void]$form.ShowDialog()
            })

        $pscmd.runspace = $rs
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Launching the runspace"
        [void]$pscmd.BeginInvoke()

        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Creating the flag file $env:temp\pscountdown-flag.txt"
        "[{0}] PSClock started by {1} under PowerShell process id $pid" -f (Get-Date), $env:USERNAME |
        Out-File -FilePath $env:temp\pscountdown-flag.txt

    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

} #close function
