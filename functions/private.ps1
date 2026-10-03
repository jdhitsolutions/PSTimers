#these are private functions

#define a custom Verbose function

function _verbose {
    [CmdletBinding()]
    Param([string]$Message)

    $m = "[{0}] $([char]27)[92;3m{1}$([char]27)[0m" -f (Get-Date).TimeOfDay, $Message
    Microsoft.PowerShell.Utility\Write-Verbose $m
}


