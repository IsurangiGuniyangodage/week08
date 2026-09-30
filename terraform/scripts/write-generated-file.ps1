$ErrorActionPreference = "Stop"

$outputPath = $env:OUTPUT_PATH
$contentBase64 = $env:CONTENT_BASE64

if ([string]::IsNullOrWhiteSpace($outputPath)) {
    throw "OUTPUT_PATH was not supplied by Terraform."
}

if ([string]::IsNullOrWhiteSpace($contentBase64)) {
    throw "CONTENT_BASE64 was not supplied by Terraform."
}

$outputDirectory = Split-Path -Parent $outputPath

if (-not (Test-Path -LiteralPath $outputDirectory)) {
    New-Item `
        -ItemType Directory `
        -Path $outputDirectory `
        -Force | Out-Null
}

$contentBytes = [Convert]::FromBase64String($contentBase64)
$content = [Text.Encoding]::UTF8.GetString($contentBytes)

[IO.File]::WriteAllText(
    $outputPath,
    $content,
    [Text.UTF8Encoding]::new($false)
)

Write-Host "Generated configuration file: $outputPath"