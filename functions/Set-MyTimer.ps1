Function Set-MyTimer {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType("MyTimer")]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullOrEmpty()]
        [SupportsWildcards()]
        [String]$Name,
        [ValidateScript({
            if (-Not $Global:MyWatchCollection.ContainsKey($_)) {
                $True
            }
            else {
                Throw "The proposed new name $_ already exists."
                $False
            }
        })]
        [String]$NewName,
        [DateTime]$Start,
        [String]$Description,
        [Switch]$PassThru
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"
    } #begin

    Process {
        Write-Verbose "[PROCESS] Using PSBoundParameters: `n $(New-Object PSObject -Property $PSBoundParameters | Out-String)"
        $timers = ($global:MyTimerCollection).Values.where({$_.name -like $name})

        if ($timers.count -ge 1) {
            foreach ($timer in $timers) {
                Write-Verbose "[PROCESS] Setting timer $($timer.name)"
                if ($PSCmdlet.ShouldProcess($Name)) {
                    if ($Description) {
                        $timer.description = $Description
                    }
                    if ($start) {
                        $timer.start = $Start
                    }
                    #set the new name last
                    if ($NewName) {
                        $oldName = $timer.name
                        $timer.Name = $NewName
                        #Need to update hash tables with new name
                        $Global:MyTimerCollection.Remove($OldName)
                        $Global:MyTimerCollection.Add($NewName,$timer)
                        #add the new name
                        $Global:MyWatchCollection.Add($NewName,$Global:MyWatchCollection[$OldName])
                        $Global:MyWatchCollection.Remove($OldName)
                    }
                    if ($PassThru) {
                        $timer.Refresh()
                        $timer
                    }
                }
            } #foreach
        } #if $timers
        else {
            # Modified from [PR#12](https://github.com/jdhitsolutions/PSTimers/pull/12)
            #Use an ANSI escape sequence to make the prompt stand out
            $Title ="$([char]27)[1;38;5;200m$($MyInvocation.MyCommand)$([char]27)[0m"
            $Message = "Can't find a matching timer object. Would you like to create a new one?"
            $Y = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes","Create a new timer."
            $N = New-Object System.Management.Automation.Host.ChoiceDescription "&No","Abort the command."
            $Options = [System.Management.Automation.Host.ChoiceDescription[]]($Y,$N)
            $Choice = $host.UI.PromptForChoice($Title,$Message,$Options,1)
            if ($Choice -eq 0) {
                Write-Verbose "[PROCESS] Creating timer $Name"
                $new = Start-MyTimer -Name $Name -Description $Description
                if ($start) {
                    Write-Verbose "[PROCESS] Setting timer $Name start to $Start"
                    Set-MyTimer -Name $Name -Start $Start
                }
                Get-MyTimer -Name $Name
            }

        } #else timer not found
    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.MyCommand)"
    }
}
