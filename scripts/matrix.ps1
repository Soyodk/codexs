[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = "🟢 Matrix - Configuração"

# Painel de Configuração
cls
Write-Host "╔════════════════════════════════════════════╗"
Write-Host "║         CONFIGURAÇÃO DO MATRIX            ║"
Write-Host "╠════════════════════════════════════════════╣"
Write-Host "║ Digite seu nome para exibir no topo       ║"
Write-Host "╚════════════════════════════════════════════╝"
$name = Read-Host "Seu nome"

Write-Host "`nEscolha uma cor para o efeito Matrix:"
Write-Host "1 - Verde (padrão)"
Write-Host "2 - Azul"
Write-Host "3 - Vermelho"
Write-Host "4 - Ciano"
Write-Host "5 - Roxo"
$colorChoice = Read-Host "Número da cor (1-5)"

# Definir cor RGB
switch ($colorChoice) {
    "2" { $r = 0;   $g = 128; $b = 255 }
    "3" { $r = 255; $g = 0;   $b = 0   }
    "4" { $r = 0;   $g = 255; $b = 255 }
    "5" { $r = 128; $g = 0;   $b = 255 }
    default { $r = 0; $g = 255; $b = 0 }
}

# Começar Matrix
cls
$Host.UI.RawUI.WindowTitle = "🟢 Matrix - $name"
$width = $Host.UI.RawUI.WindowSize.Width

function Write-RGBLine {
    param ($text)
    Write-Host "`e[38;2;${r};${g};${b}m$text`e[0m"
}

# Mostrar nome no topo
for ($i = 0; $i -lt 3; $i++) {
    cls
    Write-RGBLine (" " * [math]::Floor(($width - $name.Length) / 2) + $name.ToUpper())
    Start-Sleep -Milliseconds 300
    cls
    Start-Sleep -Milliseconds 200
}

# Iniciar efeito Matrix
for ($i = 0; $i -lt 200; $i++) {
    $line = ""
    for ($j = 0; $j -lt $width; $j++) {
        $char = Get-Random -InputObject @("0", "1", " ")
        $line += $char
    }
    Write-RGBLine $line
    Start-Sleep -Milliseconds 80
}
