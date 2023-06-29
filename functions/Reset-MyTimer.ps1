Function Reset-MyTimer {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('None','MyTimer')]
    Param(
        [Parameter(
            Position = 0,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Reset a MyTimer object.'
        )]
        [ValidateNotNullOrEmpty()]
        [ArgumentCompleter({ $global:MyTimerCollection.values.where({ $_.status -eq 'Paused' }).Name.Foreach({ if ($_ -match '\s') { "'$_'" } else { $_ } }) })]
        [String]$Name,
        [Parameter(HelpMessage = 'Return the timer object after resetting it.')]
        [Switch]$PassThru
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under PowerShell version $($PSVersionTable.PSVersion)"
    } #begin

    Process {
        $timer = $global:MyTimerCollection[$Name]
        if ($PSCmdlet.ShouldProcess($timer.name)) {
            $timer.ResetTimer()
            if ($PassThru) {
                Get-MyTimer -Name $timer.name
            }
        } #WhatIf
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Resetting timer $Name"
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close Reset-MyTimer