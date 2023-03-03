# PSTimers

[![PSGallery Version](https://img.shields.io/powershellgallery/v/PSTimers.png?style=for-the-badge&label=PowerShell%20Gallery)](https://www.powershellgallery.com/packages/PSTimers/) [![PSGallery Downloads](https://img.shields.io/powershellgallery/dt/PSTimers.png?style=for-the-badge&label=Downloads)](https://www.powershellgallery.com/packages/PSTimers/)

A set of PowerShell functions to be used as timers and countdown tools.

This module is available from the PowerShell Gallery.

```powershell
Install-Module PSTimers
```

I use several of these tools regularly.

* [Export-MyTimer](Docs/Export-MyTimer.md)
* [Get-HistoryRuntime](Docs/Get-HistoryRuntime.md)
* [Get-MyTimer](Docs/Get-MyTimer.md)
* [Import-MyTimer](Docs/Import-MyTimer.md)
* [Remove-MyTimer](Docs/Remove-MyTimer.md)
* [Set-MyTimer](Docs/Set-MyTimer.md)
* [Start-MyTimer](Docs/Start-MyTimer.md)
* [Start-PSCountdown](Docs/Start-PSCountdown.md)
* [Start-PSCountdownTimer](Docs/Start-PSCountdownTimer.md)
* [Stop-PSCountdownTimer](Docs/Stop-PSCountdownTimer.md)
* [Start-PSTimer](Docs/Start-PSTimer.md)
* [Stop-MyTimer](Docs/Stop-MyTimer.md)

The commands should also work on PowerShell 7 cross-platform, although there may be a few artifacts on non-Windows systems. It is recommended that you run PowerShell 7.2 or later on non-Windows systems.

## MyTimer

This module incorporates commands from a previous module to create simple timer objects. The MyTimer object is defined in a private PowerShell class.

```powershell
   TypeName: MyTimer

Name        MemberType  Definition
----        ----------  ----------
Equals      Method      bool Equals(System.Object obj)
GetHashCode Method      int GetHashCode()
GetStatus   Method      timespan GetStatus()
GetType     Method      type GetType()
StopTimer   Method      void StopTimer()
ToString    Method      string ToString()
Description Property    string Description {get;set;}
Duration    Property    timespan Duration {get;set;}
End         Property    datetime End {get;set;}
Name        Property    string Name {get;set;}
Running     Property    bool Running {get;set;}
Start       Property    datetime Start {get;set;}
History     PropertySet History {Name, Start, End, Duration, Description}
```

You can create a new timer from the prompt.

```powershell
PS C:\> Start-MyTimer revisions -Description "module updates"

Name            Start                  Stop         Duration         Running Description
----            -----                  ----         --------         ------- -----------
revisions       3/2/2023 3:13:23 PM                 00:00:00            True module updates
```

You can start as many timers as you need.

```powershell
PS C:\> $a = Start-Mytimer a -Description email
PS C:\> $b = Start-MyTimer
```

Use `Get-MyTimer` to view.

```powershell
PS C:\> Get-MyTimer

Name      Start               Stop Duration         Running Description
----      -----               ---- --------         ------- -----------
MyTimer   3/2/2023 2:57:29 PM      00:19:53.2590571    True
revisions 3/2/2023 3:13:23 PM      00:03:58.9337823    True module updates
a         3/2/2023 3:15:26 PM      00:01:55.9419730    True email
```

When you are finished, you can stop the timer.

```powershell
PS C:\> Stop-MyTimer revisions

Name        : revisions
Start       : 3/2/2023 3:13:23 PM
End         : 3/2/2023 3:18:15 PM
Duration    : 00:04:52.3328308
Description : module updates
```

The timer will exist for the duration of your PowerShell session.

```powershell
PS C:\> Get-MyTimer revisions

Name      Start               Stop                Duration         Running Description
----      -----               ----                --------         ------- -----------
revisions 3/2/2023 3:13:23 PM 3/2/2023 3:18:15 PM 00:04:52.3328308   False module updates
```

Although there are provisions for exporting and importing timers.

## Start-PSCountdown

The `Start-PSCountdown` command uses `Write-Progress` to display countdown information. PowerShell 7.2 uses a minimized progress display and a different set of color options based on `$PSStyle`.

![PS7 PSCountdown](images/ps7-pscountdown.png)

If you would like to use the legacy progress display in PowerShell 7, you should configure it before running `Start-PSCountdown`.

```powershell
$PSStyle.View = "Classic"
```

Set it to `Minimal` to restore.

`Start-PSCountdown` will automatically detect `$PSStyle` and adjust colors accordingly. It is recommended that you use PowerShell 7.2 or later.

## PSCountdownTimer

An alternative to `Start-PSCountdown` is [`Start-PSCountdownTimer`](Docs/Start-PSCountdownTimer.md).

```powershell
Start-PSCountdownTimer -seconds 600 -message "The PowerShell magic begins in " -FontSize 64 -Color SpringGreen -OnTop
```

![PSCountdownTimer](images/pscountdowntimer.png)

This is a transparent WPF form that displays a countdown timer and an optional message. You can control it by changing values in the `$PSCountdownClock` synchronized hashtable.

```powershell
PS C:\> $PSCountdownClock

Name                           Value
----                           -----
StartingPosition
Running                        True
Seconds                        600
Color                          SpringGreen
FontWeight                     Normal
FontFamily                     Segoi UI
CurrentPosition                {1334, 532}
OnTop                          True
Runspace                       System.Management.Automation.Runspaces.LocalRunspace
Message                        The PowerShell magic begins in
FontStyle                      Normal
Started                        10/14/2022 4:21:13 PM
FontSize                       64
AlertColor                     Yellow
WarningColor                   Red
Alert                          50
Warning                        30

PS C:\> $PSCountdownClock.OnTop = $False
```

At 50 seconds the color will change to yellow and then to red at 30 seconds.

You can stop the clock by right-clicking on the form, setting the `Running` hashtable value to `$False`, or running `Stop-PSCountdownTimer`. This is the recommended way. The WPF countdown runs in a separate runspace. If you close the PowerShell session where you started the countdown, the timer will terminate.

Because the timer runs in a separate runspace, the timer itself cannot initiate an action at the end of the timer. If you would like to create automation around the countdown timer, you could create a PowerShell script like this. The sample requires a Windows platform.

```powershell
Clear-Host
Start-PSCountdownTimer -seconds 60 -message "The PowerShell magic begins in " -FontSize 64 -Color SpringGreen
Do {
    Start-Sleep -Seconds 1
} While ($PSCountdownClock.Running)
Write-Host "Are you ready for some PowerShell?" -ForegroundColor magenta -BackgroundColor gray

#play a startup song
Add-Type -AssemblyName PresentationCore
$filename = "c:\work\01-Start.mp3"

$global:MediaPlayer = New-Object System.Windows.Media.MediaPlayer
$global:MediaPlayer.Open($filename)
$global:MediaPlayer.Play()

#the media player launches with no UI. Use the object's methods to control it.
# MediaPlayer.stop()
# $MediaPlayer.close()
```

## Related Tools

For a related project, take a look at the [PSClock](https://github.com/jdhitsolutions/PSClock) module.
