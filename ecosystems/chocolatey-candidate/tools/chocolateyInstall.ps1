$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$source = Join-Path $toolsDir 'aitextcleaner-formatting-residue.ps1'
if (-not (Test-Path -LiteralPath $source)) {
    throw "Candidate source file is missing: $source"
}

# Candidate only: publishing and account setup are intentionally not performed.
