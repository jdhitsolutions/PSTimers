# MyTimer
## about_MyTimer

## SHORT DESCRIPTION

This module contains several commands designed to work with a very simple timer.

The commands are based on an extremely basic principal: how much time has elapsed between two events? You can easily do this now with New-Timespan or simply subtracting one datetime from another. This module takes the simplest approach possible: save the current date and time to a read-only variable and when you are ready, calculate a timespan from that variable. Even though the commands reference a timer object there really isn't anything fancy or complicated. It is simply a variable that you can name, that has a datetime value.

## LONG DESCRIPTION

There's no .NET magic or anything complicated. The module commands are designed to make it easier to manage all of this. You can even create multiple timers at the same time in case you want to stop them at different intervals. When you are ready to stop a timer, run Stop-Mytimer and specify the timer name. The result will be a Timespan object.

Use Get-myTimer to view the status of all your timers but without stopping them.

### Exporting and Importing

If you need to persist timers across PowerShell sessions you can export a single timer or all timers with Export-MyTimer. Timers will be exported to an XML file using Export-Clixml. In the other PowerShell session use Import-MyTimer to recreate them in the current session. The running time will continue from when they were first created.

## EXAMPLES

Create a single timer:

```powershell
PS C:\> Start-MyTimer -Name A
```

Start multiple timers:

```powershell
PS C:\> Start-Mytimer B,C
```

Start a timer with a description:

```powershell
PS C:\> Start-Mytimer D -description "work stuff"
```

View status of all running timers:

```powershell
PS C:\> get-mytimer


Name        : a
Start       : 7/17/2018 11:58:29 AM
Duration    : 00:01:35.8207599
Running     : True
Description : 

Name        : b
Start       : 7/17/2018 11:58:48 AM
Duration    : 00:01:17.2018209
Running     : True
Description : 

Name        : c
Start       : 7/17/2018 11:58:48 AM
Duration    : 00:01:17.2028212
Running     : True
Description : 

Name        : D
Start       : 7/17/2018 11:59:33 AM
Duration    : 00:00:32.2026901
Running     : True
Description : work stuff
```

Stop a timer:

```powershell

PS C:\> stop-mytimer C

Name        : c
Start       : 7/17/2018 11:58:48 AM
Duration    : 00:01:40.4864091
Running     : False
Description :
```

You can also export and import timers if you need them to persist across PowerShell sessions. Otherwise the timers are removed when your PowerShell session ends.

## KEYWORDS

- Timer

- Timespan
