$OutputEncoding = [System.Text.Encoding]::UTF8

# Укажите здесь путь к основной папке
$basePath = "D:\convert"

# Получаем все файлы PNG и WEBP во всех вложенных папках
$extensions = @('*.png', '*.webp', '*.jpeg', '*.jpg', '*.gif')
$files = Get-ChildItem -Path $basePath -Recurse -Include $extensions

# Словарь для хранения индексов файлов в каждой папке
$folderIndexes = @{}

foreach ($file in $files) {
    # Получаем директорию текущего файла
    $directory = $file.DirectoryName

    # Создаем подпапку "converted" в текущей директории
    $convertedDir = Join-Path $directory "converted"
    if (-not (Test-Path $convertedDir)) {
        New-Item -ItemType Directory -Path $convertedDir
    }

    # Определяем имя папки
    $folderName = [System.IO.Path]::GetFileName($directory)

    # Инициализируем или получаем текущий индекс для этой папки
    if (-not $folderIndexes.ContainsKey($folderName)) {
        $folderIndexes[$folderName] = 1
    }

    # Формируем имя выходного файла с индексом
    $index = $folderIndexes[$folderName]
    $jpgFileName = "$folderName $index.jpg"
    $outputFile = Join-Path $convertedDir $jpgFileName

    # Применяем команду ImageMagick для конвертации в JPG
    magick "$($file.FullName)" -fuzz 10% -trim +repage -resize 1000x1000 -gravity center -background white -extent 1000x1000 "$outputFile"

    # Увеличиваем индекс для следующего файла в той же папке
    $folderIndexes[$folderName]++
}

Write-Host "Конвертация завершена."