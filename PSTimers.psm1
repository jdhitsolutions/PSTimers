#dot source file with function definitions
Get-Childitem $PSScriptRoot\Functions |
Foreach-Object {
    . $_.fullname
}

#add autocompleter for MyTimer functions
$cmds = "Get-MyTimer","Set-MyTimer","Remove-MyTimer"
Register-ArgumentCompleter -CommandName $cmds -ParameterName Name -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete="*", $commandAst, $fakeBoundParameter)

    $global:myTimerCollection.keys |
    where-object {$_ -match $wordToComplete } |
    Sort-Object |
        ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue',$_)
        }
}

Register-ArgumentCompleter -CommandName Stop-Mytimer -ParameterName Name -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete="*", $commandAst, $fakeBoundParameter)

    $global:myTimerCollection.values.where({$_.running}) |
    where-object {$_ -match $wordToComplete } |
    Sort-Object -Property Name |
        ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_.name, $_.name, 'ParameterValue',$_.name)
        }
}