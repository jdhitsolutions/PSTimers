# MyTimer
## about_MyTimer

# SHORT DESCRIPTION
This module contains several commands designed to work with a very simple timer.

The commands are based on an extremely basic principal: how much time has elapsed between two events? You can easily do this now with New-Timespan or simply subtracting one datetime from another. This module takes the simplest approach possible: save the current date and time to a read-only variable and when you are ready, calculate a timespan from that variable. Even though the commands reference a timer object there really isn't anything fancy or complicated. It is simply a variable that you can name, that has a datetime value.

# LONG DESCRIPTION
There's no .NET magic or anything complicated. The module commands are designed to make it easier to manage all of this. You can even create multiple timers at the same time in case you want to stop them at different intervals. When you are ready to stop a timer, run Stop-Mytimer and specify the timer name. The result will be a Timespan object.

Note that 
If you forget what names you've given your timers, you can use the Find-MyTimer or Get-MyTimer commands.

Use Get-myTimer to view the status of all your timers but without stopping them.

## Exporting and Importing
If you need to persist timers across PowerShell sesssions you can export a single timer or all timers with Export-MyTimer. Timers will be exported to an XML file using Export-Clixml. In the other PowerShell session use Import-MyTimer to recreate them in the current session. The running time will continue from when they were first created.

# EXAMPLES
Create a single timer:

    PS C:\> Start-MyTimer -Name A

Start multiple timers 

    PS C:\> Start-Mytimer B,C

View status of all the timers

    PS C:\> get-mytimer
    
    Name Started              Elapsed         
    ---- -------              -------         
    A    1/12/2017 9:29:52 PM 00:13:31.6935991
    B    1/12/2017 9:42:41 PM 00:00:41.9368038
    C    1/12/2017 9:42:41 PM 00:00:41.9367725

Stop a timer:

    PS C:\> stop-mytimer C
    
    
    Days              : 0
    Hours             : 0
    Minutes           : 1
    Seconds           : 27
    Milliseconds      : 773
    Ticks             : 877731322
    TotalDays         : 0.0010158927337963
    TotalHours        : 0.0243814256111111
    TotalMinutes      : 1.46288553666667
    TotalSeconds      : 87.7731322
    TotalMilliseconds : 87773.1322

The result is a Timespan object. The variable C is removed. Or you can stop the timer and get the result as a string.

    PS C:\> $t = stop-mytimer b -AsString
    PS C:\> $t
    00:03:09.8533324

# NOTE
When you stop a timer the original variable is removed. 

It is recommended that you give your timers meaningful names.

# TROUBLESHOOTING NOTE
Please post any problems or questions on the project's Issues page on GitHub at https://github.com/jdhitsolutions/MyTimer/issues.


# SEE ALSO
Read the original blog post at http://bit.ly/29AlSPj

# KEYWORDS
- Timer
- Timespan

