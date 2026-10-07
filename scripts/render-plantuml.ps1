<#
.SYNOPSIS
  Renderiza los bloques ```plantuml de las notas a SVG con PlantUML.
.DESCRIPTION
  Busca todos los bloques fenceados como plantuml en .md dentro de -ContentDir,
  genera su SVG en una carpeta assets/ junto a cada nota y (con -Rewrite)
  inserta la imagen antes del codigo fuente. Pensado para correr en CI (pwsh)
  y localmente (Windows PowerShell 5.1 / pwsh).
#>
[CmdletBinding()]
param(
    [string]$ContentDir = "content",
    [string]$JarPath = "",
    [switch]$Rewrite
)

$ErrorActionPreference = "Stop"

function Resolve-PlantumlJar {
    if ($JarPath) { return $JarPath }
    if ($env:PLANTUML_JAR -and (Test-Path -LiteralPath $env:PLANTUML_JAR)) { return $env:PLANTUML_JAR }
    if (Test-Path -LiteralPath "plantuml.jar") { return (Resolve-Path -LiteralPath "plantuml.jar").Path }
    throw "No se encontró plantuml.jar. Usa -JarPath o define la variable PLANTUML_JAR."
}

$jar = Resolve-PlantumlJar
if (-not (Get-Command java -ErrorAction SilentlyContinue)) {
    throw "No se encontró 'java' en el PATH. Instala un JRE 17+."
}

$fencePattern = [regex]'(?ms)^```plantuml[ \t]*\r?\n(.*?)^```[ \t]*\r?$'
$contentRoot = (Resolve-Path -LiteralPath $ContentDir).Path
$mdFiles = Get-ChildItem -LiteralPath $ContentDir -Recurse -Filter *.md -File
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

$totalBlocks = 0
$rendered = 0
$failed = 0

foreach ($md in $mdFiles) {
    $text = [System.IO.File]::ReadAllText($md.FullName, [System.Text.Encoding]::UTF8)
    $blocks = $fencePattern.Matches($text)
    if ($blocks.Count -eq 0) { continue }

    $slug = ($md.BaseName -replace '[^A-Za-z0-9]+', '-').Trim('-').ToLower()
    $assetsDir = Join-Path $md.DirectoryName "assets"
    if (-not (Test-Path -LiteralPath $assetsDir)) {
        New-Item -ItemType Directory -Path $assetsDir | Out-Null
    }

    $replacements = @()
    $index = 0
    foreach ($m in $blocks) {
        $index++
        $totalBlocks++
        $base = "$slug-$index"
        $pumlPath = Join-Path $assetsDir "$base.puml"
        $svgPath = Join-Path $assetsDir "$base.svg"
        $code = $m.Groups[1].Value

        [System.IO.File]::WriteAllText($pumlPath, $code, $utf8NoBom)

        $prevEap = $ErrorActionPreference
        $ErrorActionPreference = "Continue"
        $out = & java "-Dfile.encoding=UTF-8" -jar $jar -tsvg $pumlPath 2>&1 | Out-String
        $javaExit = $LASTEXITCODE
        $ErrorActionPreference = $prevEap
        $svgOk = Test-Path -LiteralPath $svgPath
        $ok = ($javaExit -eq 0) -and $svgOk -and ($out -notmatch 'Error line') -and ($out -notmatch 'ERROR')

        Remove-Item -LiteralPath $pumlPath -ErrorAction SilentlyContinue

        if (-not $ok) {
            $failed++
            Write-Warning "PlantUML falló en $($md.Name) (diagrama #$index):`n$out"
            if (Test-Path -LiteralPath $svgPath) { Remove-Item -LiteralPath $svgPath -Force }
            continue
        }

        $rendered++
        if ($Rewrite) {
            $dirRel = $md.DirectoryName.Substring($contentRoot.Length).TrimStart('\', '/') -replace '\\', '/'
            $imgRel = if ($dirRel) { "$dirRel/assets/$base.svg" } else { "assets/$base.svg" }
            $img = "![$($md.BaseName) - diagrama $index]($imgRel)`n`n"
            $replacements += [pscustomobject]@{ Start = $m.Index; Length = $m.Length; Text = $img + $m.Value }
        }
    }

    if ($Rewrite -and $replacements.Count -gt 0) {
        for ($i = $replacements.Count - 1; $i -ge 0; $i--) {
            $r = $replacements[$i]
            $text = $text.Substring(0, $r.Start) + $r.Text + $text.Substring($r.Start + $r.Length)
        }
        [System.IO.File]::WriteAllText($md.FullName, $text, $utf8NoBom)
    }
}

Write-Host "PlantUML: $rendered/$totalBlocks diagramas renderizados (rewrite=$Rewrite)."
if ($failed -gt 0) {
    Write-Warning "$failed diagrama(s) con errores de sintaxis. Revisa los bloques plantuml."
    exit 1
}
