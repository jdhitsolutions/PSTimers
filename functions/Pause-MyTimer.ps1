Function Suspend-MyTimer {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('None','MyTimer')]
    [alias('Pause-MyTimer')]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Pause a MyTimer object.'
        )]
        [ValidateNotNullOrEmpty()]
        [ArgumentCompleter({$global:MyTimerCollection.values.where({$_.status -eq 'Running'}).Name.Foreach({ if ($_ -match "\s") {"'$_'"} else {$_}})})]
        [Alias("Timer")]
        [String]$Name,

        [Parameter(HelpMessage = 'Write the MyTimer object to the pipeline after pausing it.')]
        [Switch]$PassThru
    )

    Begin {
        _verbose ($strings.Starting -f $MyInvocation.MyCommand)
        _verbose ($strings.Running -f $PSVersionTable.PSVersion)
        _verbose ($strings.Detected -f $host.Name)
    } #begin

    Process {
        $timer = $global:MyTimerCollection[$Name]
        if ($timer.Status -eq 'Running') {
            if ($PSCmdlet.ShouldProcess($timer.name)) {
                $timer.PauseTimer()
                if ($PassThru) {
                    Get-MyTimer -Name $timer.name
                }
            } #WhatIf
        }
        else {
            Write-Warning ($strings.WarnPause -f $timer.name,$timer.Status)
        }
        _verbose "$($strings.Pausing -f $Name)"
    } #process

    End {
        _verbose ($strings.Ending -f  $MyInvocation.MyCommand)
    } #end

} #close Suspend-MyTimer