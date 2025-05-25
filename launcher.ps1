[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = "🎮 Sistema de Diversão RGB"

function Write-RGB {
    param ($text, $r, $g, $b)
    Write-Host "`e[38;2;${r};${g};${b}m$text`e[0m"
}

# Banner
$banner = @"
 #####    #####   ######    ######   #####             #####   ######## ##  ##    ####    #######
##   ##  ##   ##   ##  ##     ##    ##   ##           ##   ##  #  ##  # ##  ##     ##      ##  ##
##       ##   ##   ##  ##     ##    ##                ##          ##    ##  ##     ##      ##
##       ##   ##   ##  ##     ##    ##                 #####      ##     ####      ##      ####
##       ##   ##   ##  ##     ##    ##  ###                ##     ##      ##       ##      ##
##   ##  ##   ##   ##  ##     ##    ##   ##           ##   ##     ##      ##       ## ##   ##  ##
 #####    #####   ######    ######   #####             #####     ####    ####     ######  #######
"@
$colors = @(
    @{R=255; G=0;   B=0},
    @{R=255; G=128; B=0},
    @{R=255; G=255; B=0},
    @{R=0;   G=255; B=0},
    @{R=0;   G=255; B=255},
    @{R=0;   G=128; B=255},
    @{R=128; G=0;   B=255},
    @{R=255; G=0;   B=255}
)

cls
$i = 0
$banner.Split("`n") | ForEach-Object {
    $c = $colors[$i % $colors.Count]
    Write-RGB $_ $c.R $c.G $c.B
    $i++
}

# Base da pasta de scripts no GitHub
$repoBase = "https://api.github.com/repos/USUARIO/REPO/contents/scripts"
$rawBase  = "https://raw.githubusercontent.com/USUARIO/REPO/main/scripts"

# Baixar lista de arquivos da pasta scripts/
try {
    $files = Invoke-RestMethod -Uri $repoBase -UseBasicParsing
    $scripts = $files | Where-Object { $_.name -like "*.ps1" }
}
catch {
    Write-Host "Erro ao buscar scripts do GitHub. Verifique a URL."
    pause
    exit
}

# Mostrar menu dinâmico
Write-Host ""
Write-RGB "╔════════════════════════════════════════════╗" 0 255 128
Write-RGB "║        MENU DE SCRIPTS DISPONÍVEIS        ║" 0 255 128
Write-RGB "╠════════════════════════════════════════════╣" 0 255 128

$index = 1
$map = @{}

foreach ($script in $scripts) {
    $name = [System.IO.Path]::GetFileNameWithoutExtension($script.name)
    Write-RGB ("║  {0,2} - {1,-35}║" -f $index, $name) 128 255 255
    $map[$index.ToString()] = $script.name
    $index++
}

Write-RGB "║  0  - Sair                                 ║" 255 128 128
Write-RGB "╚════════════════════════════════════════════╝" 0 255 128
Write-Host ""

# Ler opção
$choice = Read-Host "Digite uma opção"

if ($choice -eq "0") {
    exit
}
elseif ($map.ContainsKey($choice)) {
    $scriptFile = $map[$choice]
    $scriptUrl  = "$rawBase/$scriptFile"

    try {
        $code = Invoke-WebRequest $scriptUrl -UseBasicParsing
        Invoke-Expression $code.Content
    } catch {
        Write-Host "Erro ao executar o script '$scriptFile'."
        pause
    }
}
else {
    Write-Host "Opção inválida."
    pause
}
