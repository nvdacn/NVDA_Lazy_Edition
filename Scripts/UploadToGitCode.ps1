# Set error handling
$ErrorActionPreference = "Stop"

try {
    # Get latest tag name
    Write-Host "Getting latest tag name..."
    $tagName = git describe --tags --abbrev=0
    if (-not $tagName) {
        throw "No tags found, please ensure tags are created"
    }
    Write-Host "Current tag: $tagName"

    # Construct file name
    $baseName = "NVDA_Lazy_Edition"
    $safeTag = switch -Regex ($tagName) {
        "^\d{4}\.\d{2}\.\d{2}$" { $tagName }
        "^\d{4}\.\d{2}\.\d{2}\(beta\)$" { $tagName -replace '\(beta\)', '_beta' }
        default { $tagName -replace '[^\w\.-]', '_' }
    }
    $fileName = "${baseName}_${safeTag}.zip"
    Write-Host "File name: $fileName"

    # Create target directory if it doesn't exist
    $archiveDir = Join-Path $PSScriptRoot "../Build/Archive"
    if (-not (Test-Path $archiveDir)) {
        New-Item -ItemType Directory -Path $archiveDir -Force | Out-Null
        Write-Host "Created directory: $archiveDir"
    }

    # Download file if it doesn't exist
    $outputPath = Join-Path $archiveDir $fileName
    if (Test-Path $outputPath) {
        $fileSize = (Get-Item $outputPath).Length / 1MB
        Write-Host ("File already exists, skipping download.`nFile location: $outputPath (Size: {0:N2} MB)" -f $fileSize)
    } else {
        $downloadUrl = "https://github.com/nvdacn/NVDA_Lazy_Edition/releases/download/$tagName/$fileName"
        Write-Host "Downloading file from GitHub..."
        Write-Host "Download URL: $downloadUrl"
        
        try {
            Invoke-WebRequest -Uri $downloadUrl -OutFile $outputPath -UseBasicParsing
            if (Test-Path $outputPath) {
                $fileSize = (Get-Item $outputPath).Length / 1MB
                Write-Host ("Download completed: $outputPath (Size: {0:N2} MB)" -f $fileSize)
            } else {
                throw "File download failed"
            }
        } catch {
            throw "Download failed: $_"
        }
    }

    # Get GitCode Token
    $tokenFile = Join-Path $PSScriptRoot "../.GitCodeToken"
    # While loop to ensure token is obtained
    while (-not $token) {
        $token = $env:GITCODE_TOKEN
        $tokenSource = "environment variable"
        if ($token) {continue}
        # Try to read from file
        if (Test-Path $tokenFile) {
            $token = Get-Content $tokenFile -Raw -Encoding UTF8 | ForEach-Object { $_.Trim() }
            $tokenSource = "file"
            if ($token) {continue}
        }
        Write-Host "Please enter your GitCode Token:"
        $token = Read-Host -Prompt "GitCode Token"
        $tokenSource = "user input"
    }
    
    # Output token source
    Write-Host "Token loaded from $tokenSource."
    # Save token to file only when it comes from user input
    if ($tokenSource -eq "user input") {
        Write-Host "Saving token to file..."
        $token | Out-File $tokenFile -Encoding UTF8 -NoNewline
        Write-Host "Token saved to: $tokenFile"
    }

    # Get upload URL
    Write-Host "Getting GitCode upload URL..."
    # URL encode file name using Uri.EscapeDataString
    $encodedFileName = [Uri]::EscapeDataString($fileName)
    $apiUrl = "https://api.gitcode.com/api/v5/repos/wmhn/NVDA_Lazy_Edition/releases/$tagName/upload_url?file_name=$encodedFileName"
    $headers = @{
        "PRIVATE-TOKEN" = $token
        "Accept" = "application/json"
    }
    
    try {
        $uploadInfo = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers
        # Upload file
        if ($uploadInfo -and $uploadInfo.url) {
            Write-Host "Uploading file: $fileName..."
            Write-Host "Upload URL: $($uploadInfo.url)"
            # Prepare upload request headers
            $uploadHeaders = @{}
            if ($uploadInfo.headers) {
                # Add returned headers to request
                $uploadInfo.headers.PSObject.Properties | ForEach-Object {
                    $uploadHeaders[$_.Name] = $_.Value
                }
                Write-Host "Using custom headers for upload."
            }
            
            # Execute PUT request to upload file
            $response = Invoke-WebRequest -Uri $uploadInfo.url -Method Put -InFile $outputPath -Headers $uploadHeaders -UseBasicParsing
            if ($response.StatusCode -eq 200) {
                Write-Host "Upload successful!"
                Write-Host "Response: $($response.Content)"
            }
            else {
                Write-Host "Upload failed with status code: $($response.StatusCode)"
                Write-Host "Response: $($response.Content)"
                throw "Upload failed"
            }
        }
        else {
            throw "Failed to get upload URL from API response"
        }
    }
    catch {
        Write-Host "Error during API request: $_"
        if ($_.Exception.Response) {
            $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
            $reader.BaseStream.Position = 0
            $reader.DiscardBufferedData()
            $responseBody = $reader.ReadToEnd()
            Write-Host "API response: $responseBody"
        }
        throw
    }
}
catch {
    Write-Host "Error occurred: $_"
    Write-Host "Error details: $($_.Exception.Message)"
    
    Write-Host "Script execution failed."
    exit 1
}
