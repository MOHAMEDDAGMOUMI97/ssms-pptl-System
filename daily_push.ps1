param(
    [string]$RepoPath = "C:\Users\Simo\Documents\01-PFE_MECATRONIQUE\09-Report\LATEX\OC-SSMS-LATEX",
    [string]$RemoteName = "origin",
    [string]$BranchName = "main"
)

$ErrorActionPreference = "Stop"
$date = Get-Date -Format "yyyy-MM-dd_HHmm"
$logFile = Join-Path $RepoPath "daily_push.log"

function Write-Log {
    param([string]$Message)
    $line = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] $Message"
    Add-Content -Path $logFile -Value $line
    Write-Host $line
}

try {
    Set-Location -LiteralPath $RepoPath

    # Check for remote
    $remoteUrl = git remote get-url $RemoteName 2>$null
    if (-not $remoteUrl) {
        Write-Log "WARNING: No remote '$RemoteName' configured. Skipping push."
        Write-Log "Set up your remote: git remote add origin https://github.com/username/OC-SSMS-LATEX.git"
        exit 0
    }

    # Check for changes
    $status = git status --porcelain
    if (-not $status) {
        Write-Log "No changes to commit."
        exit 0
    }

    git add .
    Write-Log "Staged all changes."

    git commit -m "Daily backup $date"
    Write-Log "Committed: Daily backup $date"

    git push $RemoteName $BranchName
    Write-Log "Pushed to $RemoteName/$BranchName successfully."

} catch {
    Write-Log "ERROR: $_"
    exit 1
}
