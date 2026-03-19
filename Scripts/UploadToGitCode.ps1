# Set error handling
$ErrorActionPreference = "Stop"

# Get latest tag name
Write-Host "Getting latest tag name..."
git fetch --quiet --tags --prune-tags
$tagName = git describe --tags --abbrev=0
if (-not $tagName) {
    Write-Host "No tags found, please ensure tags are created"
    exit 1
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
    Invoke-WebRequest -Uri $downloadUrl -OutFile $outputPath -UseBasicParsing
    if (-not (Test-Path $outputPath)) {
        Write-Host "File download failed"
        exit 1
    }
    $fileSize = (Get-Item $outputPath).Length / 1MB
    Write-Host ("Download completed: $outputPath (Size: {0:N2} MB)" -f $fileSize)
}

# Get GitCode Token
$tokenFile = Join-Path $PSScriptRoot "../.GitCodeToken"
if ($env:GITCODE_TOKEN) {
    $token = $env:GITCODE_TOKEN
    $tokenSource = "environment variable"
} elseif (Test-Path $tokenFile) {
    $token = Get-Content $tokenFile -Raw -Encoding UTF8 | ForEach-Object { $_.Trim() }
    $tokenSource = "file"
}
while (-not $token) {
    Write-Host "Please enter your GitCode Token:"
    $token = Read-Host -Prompt "GitCode Token"
    $tokenSource = "user input"
}

# Output token source
Write-Host "Token loaded from $tokenSource."

# Get upload URL
Write-Host "Getting GitCode upload URL..."
# URL encode file name using Uri.EscapeDataString
$encodedFileName = [Uri]::EscapeDataString($fileName)
$apiUrl = "https://api.gitcode.com/api/v5/repos/nvdacn/NVDA_Lazy_Edition/releases/$tagName/upload_url?file_name=$encodedFileName"
$headers = @{
    "PRIVATE-TOKEN" = $token
    "Accept" = "application/json"
}
$uploadInfo = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers
if (-not ($uploadInfo -and $uploadInfo.url)) {
    Write-Host "Failed to get upload URL from API response"
    exit 1
}
Write-Host "Upload URL: $($uploadInfo.url)"

# Save token to file only when it comes from user input
if ($tokenSource -eq "user input") {
    Write-Host "Saving token to file..."
    $token | Out-File $tokenFile -Encoding UTF8 -NoNewline
    Write-Host "Token saved to: $tokenFile"
}

# Prepare upload request headers
$uploadHeaders = @{}
$uploadInfo.headers.PSObject.Properties | ForEach-Object {
    $uploadHeaders[$_.Name] = $_.Value
}

# Execute PUT request to upload file
Write-Host "Uploading file: $fileName..."
$response = Invoke-WebRequest -Uri $uploadInfo.url -Method Put -InFile $outputPath -Headers $uploadHeaders -UseBasicParsing
if ($response.StatusCode -eq 200) {
    Write-Host "Upload successful!"
    Write-Host "Response: $($response.Content)"
} else {
    Write-Host "Upload failed with status code: $($response.StatusCode)"
    Write-Host "Response: $($response.Content)"
    exit 1
}
