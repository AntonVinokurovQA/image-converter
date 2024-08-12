$OutputEncoding = [System.Text.Encoding]::UTF8

# ������� ����� ���� � �������� �����
$basePath = "D:\convert"

# �������� ��� ����� PNG � WEBP �� ���� ��������� ������
$extensions = @('*.png', '*.webp')
$files = Get-ChildItem -Path $basePath -Recurse -Include $extensions

foreach ($file in $files) {
    # �������� ���������� �������� �����
    $directory = $file.DirectoryName

    # ������� �������� "converted" � ������� ����������
    $convertedDir = Join-Path $directory "converted"
    if (-not (Test-Path $convertedDir)) {
        New-Item -ItemType Directory -Path $convertedDir
    }

    # ��������� ���� ��� ���������� ����������������� ����� � ������� JPG
    $jpgFileName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name) + ".jpg"
    $outputFile = Join-Path $convertedDir $jpgFileName

    # ��������� ������� ImageMagick ��� ����������� � JPG
    magick "$($file.FullName)" -trim +repage -resize 1000x1000 -gravity center -background white -extent 1000x1000 "$outputFile"
}

Write-Host "����������� ���������."