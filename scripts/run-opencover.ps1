[CmdletBinding()]
Param(
  [string]
  [Parameter(Mandatory=$true)]
  $target,

  [string]
  $filter
)

$ErrorActionPreference = "Stop"

$exeDirectory = Get-ChildItem .\packages -Directory -Recurse `
                     | Where-Object { $_.Name -match 'OpenCover.Console.exe' } `
                     | Sort-Object -Descending { $_.Name } `
                     | Select-Object -First 1
$exePath = "$($exeDirectory.FullName)\tools\OpenCover.Console.exe"

$params = " -register:user -target:""$($Env:xunit20)\xunit.console.x86.exe"" -targetargs:""$target -noshadow"" -output:""coverage.xml"""
if ($filter) {
    $params = "$params -filter:""$filter"""
}

Write-Host ""
Write-Host "Executing: '$exePath'"
Write-Host "Params: $params"
Write-Host ""
Invoke-Expression "$exePath $params"
