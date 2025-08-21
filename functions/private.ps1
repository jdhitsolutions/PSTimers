#these are private functions

#define a custom Verbose function

function _verbose {
    [CmdletBinding()]
    Param([string]$Message)

    $m = "[$([char]27)[3m{0}$([char]27)[0m] {1}" -f (Get-Date).TimeOfDay, $Message
    Microsoft.PowerShell.Utility\Write-Verbose $m
}


