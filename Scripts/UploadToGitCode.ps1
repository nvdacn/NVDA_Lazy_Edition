# Set error handling
$ErrorActionPreference = "Stop"

# Switch to parent directory of script location
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptDir

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
    $fileName = ""
    
    if ($tagName -match "^\d{4}\.\d{2}\.\d{2}$") {
        $fileName = "${baseName}_${tagName}.zip"
    }
    elseif ($tagName -match "^\d{4}\.\d{2}\.\d{2}\(beta\)$") {
        $cleanTag = $tagName -replace '\(beta\)', '_beta'
        $fileName = "${baseName}_${cleanTag}.zip"
    }
    else {
        $safeTag = $tagName -replace '[^\w\.-]', '_'
        $fileName = "${baseName}_${safeTag}.zip"
    }
    
    Write-Host "File name: $fileName"

    # Create target directory if it doesn't exist
    $archiveDir = "../Build/Archive"
    if (-not (Test-Path $archiveDir)) {
        New-Item -ItemType Directory -Path $archiveDir -Force | Out-Null
        Write-Host "Created directory: $archiveDir"
    }

    # Download file if it doesn't exist
    $outputPath = Join-Path $archiveDir $fileName
    
    if (Test-Path $outputPath) {
        $fileSize = (Get-Item $outputPath).Length / 1MB
        $message = "File already exists, skipping download.`nFile location: $outputPath (Size: {0:N2} MB)" -f $fileSize
        Write-Host $message
    }
    else {
        $downloadUrl = "https://github.com/nvdacn/NVDA_Lazy_Edition/releases/download/$tagName/$fileName"
        
        Write-Host "Downloading file from GitHub..."
        Write-Host "Download URL: $downloadUrl"
        
        # Use Invoke-WebRequest to download file
        try {
            Invoke-WebRequest -Uri $downloadUrl -OutFile $outputPath -UseBasicParsing
            
            if (Test-Path $outputPath) {
                $fileSize = (Get-Item $outputPath).Length / 1MB
                $message = "Download completed: $outputPath (Size: {0:N2} MB)" -f $fileSize
                Write-Host $message
            }
            else {
                throw "File download failed"
            }
        }
        catch {
            Write-Host "Download failed: $_"
            throw "Failed to download file from GitHub. Please check the tag name and file availability."
        }
    }

    # Get GitCode Token
    $tokenFile = "../.GitCodeToken"
    
    # Try to read from environment variable first
    Write-Host "Reading token from environment variable..."
    $token = [Environment]::GetEnvironmentVariable("GITCODE_TOKEN")

    if (-not [string]::IsNullOrWhiteSpace($token)) {
        Write-Host "Token loaded from environment variable."
    }

    # If environment variable is empty, try to read from file
    if ([string]::IsNullOrWhiteSpace($token)) {
        if (Test-Path $tokenFile) {
            Write-Host "Reading token from file..."
            $token = Get-Content $tokenFile -Raw -Encoding UTF8 | ForEach-Object { $_.Trim() }
            
            if (-not [string]::IsNullOrWhiteSpace($token)) {
                Write-Host "Token loaded from file."
            }
        }
    }
    
    # If environment variable is empty, prompt user for input
    if ([string]::IsNullOrWhiteSpace($token)) {
        Write-Host "Please enter your GitCode Token:"
        
        # Read token securely
        $secureToken = Read-Host -Prompt "GitCode Token" -AsSecureString

        # Ensure token is not empty
        if ($secureToken.Length -eq 0) {
            throw "Token cannot be empty"
        }
        
        # Save to file
        Write-Host "Saving token to file..."
        $tokenDir = Split-Path -Parent $tokenFile
        $token | Out-File $tokenFile -Encoding UTF8 -NoNewline
        Write-Host "Token saved to: $tokenFile"
    }

    # Get upload URL
    Write-Host "Getting GitCode upload URL..."
    
    # URL encode file name using Uri.EscapeDataString
    $encodedFileName = [Uri]::EscapeDataString($fileName)
    $apiUrl = "https://api.gitcode.com/api/v5/repos/WMHN/NVDA_Lazy_Edition/releases/$tagName/upload_url?access_token=$token&file_name=$encodedFileName"
    $headers = @{
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
            
            if ($response.StatusCode -in 200..299) {
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
    
    if ($_.Exception -match "404") {
        Write-Host "The file might not exist on GitHub, or the tag is incorrect."
    }
    elseif ($_.Exception -match "401" -or $_.Exception -match "403") {
        Write-Host "Authentication error. Please check your GitCode token."
    }
    
    Write-Host "Script execution failed."
    exit 1
}
