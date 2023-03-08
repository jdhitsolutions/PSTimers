# PSTimers

[![PSGallery Version](https://img.shields.io/powershellgallery/v/PSTimers.png?style=for-the-badge&label=PowerShell%20Gallery)](https://www.powershellgallery.com/packages/PSTimers/) [![PSGallery Downloads](https://img.shields.io/powershellgallery/dt/PSTimers.png?style=for-the-badge&label=Downloads)](https://www.powershellgallery.com/packages/PSTimers/)

A set of PowerShell functions to be used as timers and countdown tools.

This module is available from the PowerShell Gallery and should install in Windows PowerShell 5.1 and PowerShell 7.

```powershell
Install-Module PSTimers
```

The commands should also work on PowerShell 7 cross-platform except for those that utilize WPF. It is recommended that you run PowerShell 7.2 or later on non-Windows systems.

## :book: History Runtime

PowerShell 7 will display how long a command took to complete when using `Get-History`. [Get-HistoryRuntime](docs/Get-HistoryRuntime.md) will provide the same functionality in Windows PowerShell. By default, it gets the runtime of the last history item.

```powershell
PS C:\> $s = dir c:\scripts
PS C:\> Get-HistoryRuntime

 ID RunTime
 -- -------
292 00:00:00.2392380
```

The command has an alias of `ghr` and you can specify any history item.

```powershell
PS C:\> ghr 295 -Detail

 ID RunTime             Status Command
 -- -------             ------ -------
295 00:00:07.7998983 Completed get-winevent system -MaxEvents 1000
```

## :watch: MyTimer

>:skull: **NOTE**: The MyTimer class and related commands have been heavily revised and extended. There are several breaking changes from previous versions of this module. It is recommended that you clear existing timers before upgrading and using this version of the module.

This module incorporates commands from a previous module that creates simple timer objects.

* [Start-MyTimer](docs/Start-MyTimer.md)
* [Get-MyTimer](docs/Get-MyTimer.md)
* [Stop-MyTimer](docs/Stop-MyTimer.md)
* [Suspend-MyTimer](docs/Suspend-MyTimer.md)
* [Resume-MyTimer](docs/Resume-MyTimer.md)
* [Reset-MyTimer](docs/Reset-MyTimer.md)
* [Set-MyTimer](docs/Set-MyTimer.md)
* [Restart-MyTimer](docs/Restart-MyTimer.md)
* [Remove-MyTimer](docs/Remove-MyTimer.md)
* [Import-MyTimer](docs/Import-MyTimer.md)
* [Export-MyTimer](docs/Export-MyTimer.md)

The `MyTimer` object is defined in a private PowerShell class.

```powershell
   TypeName: MyTimer

Name            MemberType  Definition
----            ----------  ----------
Equals          Method      bool Equals(System.Object obj)
GetCurrentTimer Method      MyTimer GetCurrentTimer()
GetHashCode     Method      int GetHashCode()
GetStatus       Method      timespan GetStatus()
GetType         Method      type GetType()
PauseTimer      Method      void PauseTimer()
Refresh         Method      void Refresh()
ResetTimer      Method      void ResetTimer()
RestartTimer    Method      void RestartTimer()
ResumeTimer     Method      void ResumeTimer()
StartTimer      Method      void StartTimer()
StopTimer       Method      void StopTimer()
ToString        Method      string ToString()
Description     Property    string Description {get;set;}
Duration        Property    timespan Duration {get;set;}
End             Property    datetime End {get;set;}
Name            Property    string Name {get;set;}
Running         Property    bool Running {get;set;}
Start           Property    datetime Start {get;set;}
Status          Property    MyTimerStatus Status {get;set;}
History         PropertySet History {Name, Start, End, Duration, Description}
```

Many of the methods are called from related commands.

You can create a new timer from the prompt.

```powershell
PS C:\> Start-MyTimer revisions -Description "module updates"

Name               Start                Stop Duration     Status Description
----               -----                ---- --------     ------ -----------
revisions 3/5/2023 11:32:46 AM      00:00:00:00 Running module updates
```

You can start as many timers as you need.

```powershell
PS C:\> $a = Start-Mytimer mail -Description email
PS C:\> $b = Start-MyTimer
```

Use `Get-MyTimer` to view.

```powershell
PS C:\> Get-MyTimer

Name               Start                Stop Duration     Status Description
----               -----                ---- --------     ------ -----------
revisions 3/5/2023 11:33:18 AM      00:00:00:42 Running module updates
mail      3/5/2023 11:33:42 AM      00:00:00:19 Running email
MyTimer   3/5/2023 11:33:54 AM      00:00:00:06 Running
```

When you are finished, you can stop the timer.

```powershell
PS C:\> Stop-MyTimer mail -PassThru

Name          Start                Stop                 Duration     Status Desc
                                                                            ript
                                                                            ion
----          -----                ----                 --------     ------ ----
mail 3/5/2023 11:33:42 AM 3/5/2023 11:39:44 AM 00:00:06:02 Stopped email
```

The timer will exist for the duration of your PowerShell session.

```powershell
PS C:\> Get-MyTimer -Status Stopped | Select History


Name        : revisions
Start       : 3/5/2023 11:33:18 AM
End         : 3/5/2023 11:39:18 AM
Duration    : 00:05:59.7291106
Description : module updates

Name        : mail
Start       : 3/5/2023 11:33:42 AM
End         : 3/5/2023 11:39:44 AM
Duration    : 00:06:02.1412877
Description : email
```

Although there are provisions for exporting and importing timers.

The module includes a format ps1xml file that uses ANSI to highlight timers based on status.

![Get-MyTimers](images/mytimer.png)

Timers are managed through two hashtables created as global variables, `$MyTimerCollection` and `$MyWatchCollection`. Do not delete these variables. The MyTimer commands will update these hashtables as needed.

## :rocket: Start-PSCountdown

The [Start-PSCountdown](docs/Start-PSCountdown.md) command uses `Write-Progress` to display countdown information. PowerShell 7.2 uses a minimized progress display and a different set of color options based on `$PSStyle`.

![PS7 PSCountdown](images/ps7-pscountdown.png)

If you would like to use the legacy progress display in PowerShell 7, you should configure it before running `Start-PSCountdown`.

```powershell
$PSStyle.View = "Classic"
```

Set it to `Minimal` to restore.

`Start-PSCountdown` will automatically detect `$PSStyle` and adjust colors accordingly. It is recommended that you use PowerShell 7.2 or later.

Use `Ctrl+C` to terminate a countdown.

## :alarm_clock: PSCountdownTimer

An alternative to `Start-PSCountdown` is [Start-PSCountdownTimer](docs/Start-PSCountdownTimer.md) and related [Stop-PSCountdownTimer](docs/Stop-PSCountdownTimer.md)

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

## :computer: Start-PSTimer

For a more traditional countdown timer, you can use [Start-PSTimer](docs/Start-PSTimer.md). This is an ideal command when you have a simple countdown, say, from 10. You can invoke a script block at the countdown completion.

```powershell
PS C:\> Start-PSTimer  -Scriptblock {Get-Date} -Message "Let's Do This Thing!" -Title "Get-Ready"
```

## :hammer: Related Tools

For a related project, take a look at the [PSClock](https://github.com/jdhitsolutions/PSClock) module. Or if you need a simple to-do manager, look at the [PSWorkItem](https://github.com/jdhitsolutions/PSWorkItem) module.
