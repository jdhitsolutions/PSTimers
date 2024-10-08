#
# Module manifest for module 'PSTimers'
#

@{

    RootModule           = 'PSTimers.psm1'
    ModuleVersion        = '2.2.0'
    CompatiblePSEditions = @('Desktop', 'Core')
    GUID                 = '35c2826f-0292-40e3-a6d6-e7f5c3f09afa'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '(c) 2017-2024 JDH Information Technology Solutions, Inc.'
    Description          = 'A set of PowerShell functions to be used as timers and countdown tools. The commands should work in Windows PowerShell and PowerShell 7, often cross-platform.'
    PowerShellVersion    = '5.1'
    TypesToProcess       = @('types\MyTimer.types.ps1xml')
    FormatsToProcess     = @('formats\MyTimer.format.ps1xml')
    FunctionsToExport    = @('Start-PSCountdown',
        'Start-PSTimer', 'Get-MyTimer', 'Set-MyTimer',
        'Start-MyTimer', 'Stop-MyTimer', 'Remove-MyTimer',
        'Export-MyTimer', 'Import-MyTimer', 'Get-HistoryRuntime',
        'Start-PSCountdownTimer', 'Stop-PSCountdownTimer',
        'Suspend-MyTimer','Resume-MyTimer','Restart-MyTimer',
        'Reset-MyTimer')
    # CmdletsToExport = '*'
    # VariablesToExport = ''
    AliasesToExport      = @(
        'ton',
        'toff',
        'spsc',
        'spst',
        'ghr',
        'Pause-MyTimer'
    )
    PrivateData          = @{
        PSData = @{
            Tags       = @('timer', 'countdown', 'teaching', 'clock')
            LicenseUri = 'https://github.com/jdhitsolutions/pstimers/blob/master/LICENSE.txt'
            ProjectUri = 'https://github.com/jdhitsolutions/pstimers'
            # IconUri = ''
            # ReleaseNotes = ''

        } # End of PSData hashtable
    } # End of PrivateData hashtable

}

