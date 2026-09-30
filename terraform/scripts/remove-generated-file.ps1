$ErrorActionPreference = "Stop"

$outputPath = $env:OUTPUT_PATH

if ([string]::IsNullOrWhiteSpace($outputPath)) {
    throw "OUTPUT_PATH was not supplied by Terraform."
}

if (Test-Path -LiteralPath $outputPath) {
    Remove-Item -LiteralPath $outputPath -Force
    Write-Host "Removed generated configuration file: $outputPath"
}
else {
    Write-Host "Generated file already absent: $outputPath"
}