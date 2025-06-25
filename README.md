# Image Conversion PowerShell Script

This PowerShell script is designed to convert PNG and WEBP images to JPEG format with specific processing steps. It handles image background removal, resizes images to 1000x1000 pixels, and saves the output in a `converted` subfolder using the source folder name and an index to ensure unique filenames.

## Features

- Processes files with `.png` and `.webp` extensions.
- Removes background and resizes images to 1000x1000 pixels.
- Saves the output as JPEG files.
- File numbering starts from 1 for each folder and increments per file.
- Stores the results in a `converted` subdirectory inside each original folder.

## Installation and Usage

### 1. Install ImageMagick

Make sure you have [ImageMagick](https://imagemagick.org) installed and added to your system `PATH`.

### 2. Prepare the Script

1. Ensure the `convert.ps1` script is located in your working directory.  
2. Edit the `$basePath` variable in the script to specify the path to the main folder containing your images.

### 3. Run the Script

1. Open PowerShell as Administrator.
2. Navigate to the directory where the script is located using:

    ```powershell
    cd <path to the folder with your script>
    ```

3. Execute the script:

    ```powershell
    .\convert.ps1
    ```

The script will process all supported images and save the converted files in the
