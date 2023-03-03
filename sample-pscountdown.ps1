<#
A proof-of-concept script that adds an action at the end of the PSCountdownTimer
This requires a Windows platform.
#>
Clear-Host
Start-PSCountdownTimer -seconds 60 -message "The PowerShell magic begins in " -FontSize 64 -Color SpringGreen
Do {
    Start-Sleep -Seconds 1
} While ($PSCountdownClock.Running)

Write-Host "Are you ready for some PowerShell?" -ForegroundColor magenta -BackgroundColor gray

Add-Type –AssemblyName PresentationCore
$filename = "c:\work\01-Start.mp3"
#the media player launches with no UI. Use the object's methods to control it.
$global:MediaPlayer = New-Object System.Windows.Media.MediaPlayer
$global:MediaPlayer.Open($filename)
$global:MediaPlayer.Play()

# $MediaPlayer.stop()
# $MediaPlayer.close()