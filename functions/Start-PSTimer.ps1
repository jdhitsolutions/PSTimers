Function Start-PSTimer {
    [CmdletBinding()]
    [OutputType("None", "PSObject")]
    [Alias("spst")]

    Param(
        [Parameter(Position = 0, HelpMessage = "Enter seconds to countdown from")]
        [Int]$Seconds = 10,
        [Parameter(Position = 1, HelpMessage = "Enter a ScriptBlock to execute at the end of the countdown")]
        [alias("GlobalBlock","sb")]
        [ScriptBlock]$ScriptBlock,
        [Switch]$ProgressBar,
        [String]$Title = "Countdown",
        [Switch]$Clear,
        [String]$Message
    )

    _verbose ($strings.Starting -f $MyInvocation.MyCommand)
    _verbose ($strings.Running -f $PSVersionTable.PSVersion)
    _verbose ($strings.Detected -f $host.Name)
    #save beginning value for total seconds
    $TotalSeconds = $Seconds

    If ($clear) {
        Clear-Host
    }

    #get current cursor position
    $Coordinate = New-Object System.Management.Automation.Host.Coordinates
    $Coordinate.X = $host.UI.RawUI.CursorPosition.X
    $Coordinate.Y = $host.UI.RawUI.CursorPosition.Y
    #define the Escape key
    $ESCKey = 27

    #define a variable indicating if the user aborted the countdown
    $Abort = $False

    while ($seconds -ge 1) {

        if ($host.UI.RawUI.KeyAvailable) {
            $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp,IncludeKeyDown")

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

            $host.UI.RawUI.CursorPosition = $Coordinate
            #write the seconds with padded trailing spaces to overwrite any extra digits such
            #as moving from 10 to 9
            $pad = ($TotalSeconds -as [String]).Length
            if ($seconds -le 10) {
                $color = "Red"
            }
            else {
                $color = "Green"
            }
            $msg = @"
$Title
$(([String]$Seconds).PadRight($pad))
"@

            Write-Host $msg -ForegroundColor $color

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
            $Coordinate.X = $Coordinate.X - ([Int]($message.Length) / 2)
        }

        $host.UI.RawUI.CursorPosition = $Coordinate

        Write-Host $Message -ForegroundColor Green
        #run the ScriptBlock if specified
        if ($ScriptBlock) {
            Invoke-Command -ScriptBlock $ScriptBlock
        }
    }
    else {
        Write-Warning "Countdown aborted"
    }

    _verbose  ($strings.Ending -f $MyInvocation.MyCommand)
}
