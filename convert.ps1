$OutputEncoding = [System.Text.Encoding]::UTF8

# ������� ����� ���� � �������� �����
$basePath = "D:\convert"

# �������� ��� ����� PNG � WEBP �� ���� ��������� ������
$extensions = @('*.png', '*.webp', '*.jpeg', '*.jpg', '*.gif')
$files = Get-ChildItem -Path $basePath -Recurse -Include $extensions

# ������� ��� �������� �������� ������ � ������ �����
$folderIndexes = @{}

foreach ($file in $files) {
    # �������� ���������� �������� �����
    $directory = $file.DirectoryName

    # ������� �������� "converted" � ������� ����������
    $convertedDir = Join-Path $directory "converted"
    if (-not (Test-Path $convertedDir)) {
        New-Item -ItemType Directory -Path $convertedDir
    }

    # ���������� ��� �����
    $folderName = [System.IO.Path]::GetFileName($directory)

    # �������������� ��� �������� ������� ������ ��� ���� �����
    if (-not $folderIndexes.ContainsKey($folderName)) {
        $folderIndexes[$folderName] = 1
    }

    # ��������� ��� ��������� ����� � ��������
    $index = $folderIndexes[$folderName]
    $jpgFileName = "$folderName $index.jpg"
    $outputFile = Join-Path $convertedDir $jpgFileName

    # ��������� ������� ImageMagick ��� ����������� � JPG
    magick "$($file.FullName)" -fuzz 10% -trim +repage -resize 1000x1000 -gravity center -background white -extent 1000x1000 "$outputFile"

    # ����������� ������ ��� ���������� ����� � ��� �� �����
    $folderIndexes[$folderName]++
}

Write-Host "����������� ���������."