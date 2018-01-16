#requires -version 5.1

#TODO: Add WPF timer

#region Main


#dot source file with function definitions
. $PSScriptRoot\PSTimerFunctions.ps1

#endregion

#region define aliases

$aliases=@()
$aliases+= Set-Alias -Name ton -Value Start-MyTimer -PassThru 
$aliases+= Set-Alias -Name toff -Value Stop-MyTimer -PassThru
$aliases+= Set-Alias -Name spsc -Value Start-PSCountdown -PassThru
$aliases+= Set-Alias -Name spst -Value Start-PSTimer -PassThru
$aliases+= Set-Alias -Name ghr -Value Get-HistoryRuntime -PassThru

#endregion

#region export members

$functions = @('Start-PSCountdown', 'Start-PSTimer','Get-MyTimer', 'Start-MyTimer', 'Stop-MyTimer','Remove-MyTimer', 
'Export-MyTimer','Import-MyTimer','Get-HistoryRunTime')



Export-ModuleMember -Function $functions -Alias $aliases.Name 

#endregion