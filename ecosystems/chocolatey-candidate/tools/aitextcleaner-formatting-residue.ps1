param([Parameter(ValueFromPipeline = $true)][string]$Text)

process {
    $cleaned = $Text -replace '(?i)</?(address|article|blockquote|br|div|li|p|pre|section)\b[^>]*>', "`n"
    $cleaned = $cleaned -replace '<[^>]*>', ''
    $cleaned = $cleaned.Replace('“', '"').Replace('”', '"').Replace('‘', "'").Replace('’', "'")
    $cleaned = $cleaned.Replace('–', '-').Replace('—', '-').Replace('…', '...')
    $cleaned = $cleaned -replace '[ \t]+`n', "`n"
    $cleaned = $cleaned -replace '(`n){3,}', "`n`n"
    $cleaned.Trim()
}
