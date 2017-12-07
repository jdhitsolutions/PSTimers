#requires -version 5.1

#region Main


Function Start-PSCountdown {
[cmdletbinding()]
Param(

)

Begin {
    Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"  
} #begin

Process {


} #process

End {
    Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
} #end

} #close Start-PSCountdown

 
Function Start-PSTimer {
[cmdletbinding()]
Param(

)

Begin {
    Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"  
} #begin

Process {


} #process

End {
    Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
} #end

} #close Start-PSTimer



#endregion

#define aliases


