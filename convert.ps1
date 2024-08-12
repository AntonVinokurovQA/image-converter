$OutputEncoding = [System.Text.Encoding]::UTF8

# Укажите здесь путь к основной папке
$basePath = "D:\convert"

# Получаем все файлы PNG и WEBP во всех вложенных папках
$extensions = @('*.png', '*.webp')
$files = Get-ChildItem -Path $basePath -Recurse -Include $extensions

foreach ($file in $files) {
    # Получаем директорию текущего файла
    $directory = $file.DirectoryName

    # Создаем подпапку "converted" в текущей директории
    $convertedDir = Join-Path $directory "converted"
    if (-not (Test-Path $convertedDir)) {
        New-Item -ItemType Directory -Path $convertedDir
    }

    # Формируем путь для сохранения конвертированного файла в формате JPG
    $jpgFileName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name) + ".jpg"
    $outputFile = Join-Path $convertedDir $jpgFileName

    # Применяем команду ImageMagick для конвертации в JPG
    magick "$($file.FullName)" -trim +repage -resize 1000x1000 -gravity center -background white -extent 1000x1000 "$outputFile"
}

Write-Host "Конвертация завершена."