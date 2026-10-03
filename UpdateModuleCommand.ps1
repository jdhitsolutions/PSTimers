#requires -version 7.6
#requires -module Microsoft.PowerShell.Platyps
#requires -module pwshSpectreConsole

#Update an existing command help doc ina  module
Param(
    [Parameter(HelpMessage = "Specify the root module path")]
    [[ValidateScript({Test-Path -path $_},ErrorMessage = "Failed to find or validate {0}.")]]
    [string]$ModulePath
)

#import the Module
Try {
    Import-Module $ModulePath -force
}
Catch {
    Return $_.Exception.Message
}

$moduleName = Split-Path $ModulePath -Leaf
$choices = Get-Command -module $ModuleName -CommandType Function
$cmd = Read-SpectreSelection -Message "[gold1 italic]What is the name command to update?[/]" $choices -ChoiceLabelProperty Name
$cmdName = $cmd.Name
$md = Join-Path -Path $ModulePath -ChildPath docs -AdditionalChildPath "$cmdName.md"

Update-MarkdownHelp -path $md -PassThru
