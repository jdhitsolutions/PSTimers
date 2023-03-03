Function Set-MyTimer {

    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("MyTimer")]
    Param(
        [Parameter(Position = 0, Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [String]$Name,
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
        $timers = ($global:MyTimerCollection).Values.where( {$_.name -like $name})

        if ($timers.count -ge 1) {
            foreach ($timer in $timers) {
                Write-Verbose "[PROCESS] Setting timer $($timer.name)"
                if ($PSCmdlet.ShouldProcess($Name)) {
                    if ($Description) {
                        $timer.description = $Description
                    }
                    if ($NewName) {
                        $timer.Name = $NewName
                    }
                    if ($start) {
                        $timer.start = $Start
                    }
                    if ($PassThru) {
                        $timer
                    }
                }
            } #foreach
        } #if $timers
        else {
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
            <#
            Write-Warning "Can't find a matching timer object. Would you like to create a new one?"
            # Added from [PR#12](https://github.com/jdhitsolutions/PSTimers/pull/12)
            Switch (Read-Host  "y / n") {
                y {
                    Write-Verbose "[PROCESS] Creating timer $Name"
                    $new = Start-MyTimer -Name $Name -Description $Description
                    if ($start) {
                        Write-Verbose "[PROCESS] Setting timer $Name start to $Start"
                        Set-MyTimer -Name $Name -Start $Start
                    }
                    Get-MyTimer -Name $Name
                }
            }
            #>
        } #else timer not found
    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.MyCommand)"
    }
}
