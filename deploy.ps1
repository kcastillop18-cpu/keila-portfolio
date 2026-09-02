# Deploy portfolio y actualiza alias keilacastillo.vercel.app automaticamente
Write-Host "Publicando cambios en Vercel..." -ForegroundColor Cyan

$output = vercel --prod --yes 2>&1 | Out-String

# Extraer URL del nuevo deploy
$match = [regex]::Match($output, 'https://website-[a-z0-9]+-kcp-centix\.vercel\.app')
if ($match.Success) {
    $newUrl = $match.Value
    Write-Host "Deploy listo: $newUrl" -ForegroundColor Green

    Write-Host "Actualizando alias keilacastillo.vercel.app..." -ForegroundColor Cyan
    vercel alias set $newUrl keilacastillo.vercel.app 2>&1 | Out-Null

    Write-Host ""
    Write-Host "Sitio actualizado correctamente!" -ForegroundColor Green
    Write-Host "URL publica: https://keilacastillo.vercel.app" -ForegroundColor Yellow
} else {
    Write-Host "No se pudo extraer la URL del deploy. Revisa la salida:" -ForegroundColor Red
    Write-Host $output
}
