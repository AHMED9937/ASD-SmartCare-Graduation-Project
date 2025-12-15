# Comprehensive import fix script
Get-ChildItem -Path "lib" -Filter "*.dart" -Recurse | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $original = $content
    
    # Fix deeply nested paths that slipped through
    $content = $content -replace "features/(\w+)/views/screen/", 'features/$1/views/'
    $content = $content -replace "features/(\w+)/views/Screens/", 'features/$1/views/'
    $content = $content -replace "features/(\w+)/views/Screen/", 'features/$1/views/'
    $content = $content -replace "features/(\w+)/views/widgets/", 'features/$1/views/'
    $content = $content -replace "features/(\w+)/views/Widgets/", 'features/$1/views/'
    
    # Fix feature path fragments
    $content = $content -replace "features/doctors_list/", 'features/doctors/views/'
    $content = $content -replace "features/booking/", 'features/doctors/views/'
    
    if ($content -ne $original) {
        Set-Content -Path $_.FullName -Value $content -NoNewline
        Write-Host "Fixed: $($_.Name)" -ForegroundColor Yellow
    }
}
Write-Host "Import fix complete!" -ForegroundColor Green
