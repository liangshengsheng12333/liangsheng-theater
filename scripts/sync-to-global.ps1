# scripts/sync-to-global.ps1
# Liangsheng Opera House - Global Skill Sync Script

[CmdletBinding()]
param(
    [string]$TargetDir = "$env:USERPROFILE\.gemini\config\skills\liangsheng-theater"
)

$ErrorActionPreference = "Stop"

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "[Theater] Liangsheng Opera House Global Skill Deployment" -ForegroundColor Yellow
Write-Host "==========================================================" -ForegroundColor Cyan

$SourceDir = Split-Path -Parent $PSScriptRoot
Write-Host "Source directory: $SourceDir" -ForegroundColor Gray
Write-Host "Target directory: $TargetDir" -ForegroundColor Gray

# 1. Ensure target directory exists
if (!(Test-Path -Path $TargetDir)) {
    Write-Host "`n[1/4] Creating global skill target directory..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
    Write-Host "      Created successfully: $TargetDir" -ForegroundColor Green
} else {
    Write-Host "`n[1/4] Target directory exists, proceeding with sync..." -ForegroundColor Cyan
}

# 2. Sync core files
Write-Host "`n[2/4] Syncing core specification files..." -ForegroundColor Cyan
$coreFiles = @(
    "SKILL.md",
    "README.md",
    "GLOSSARY.md",
    "THEATER_BLUEPRINT.md",
    "LICENSE"
)

foreach ($file in $coreFiles) {
    $srcPath = Join-Path $SourceDir $file
    if (Test-Path $srcPath) {
        $destPath = Join-Path $TargetDir $file
        Copy-Item -Path $srcPath -Destination $destPath -Force
        Write-Host "      [OK] Synced: $file" -ForegroundColor Green
    } else {
        Write-Host "      [WARN] File not found: $file" -ForegroundColor Yellow
    }
}

# 3. Recursively sync directories
Write-Host "`n[3/4] Syncing templates, docs, scripts, and assets..." -ForegroundColor Cyan
$directories = @(
    "templates",
    ".theater",
    "docs",
    "scripts"
)

foreach ($dir in $directories) {
    $srcSub = Join-Path $SourceDir $dir
    if (Test-Path $srcSub) {
        $destSub = Join-Path $TargetDir $dir
        if (!(Test-Path $destSub)) {
            New-Item -ItemType Directory -Path $destSub -Force | Out-Null
        }
        Copy-Item -Path "$srcSub\*" -Destination $destSub -Recurse -Force
        Write-Host "      [OK] Synced directory: $dir" -ForegroundColor Green
    }
}

# 4. Verification
Write-Host "`n[4/4] Verifying deployment integrity..." -ForegroundColor Cyan
$targetSkill = Join-Path $TargetDir "SKILL.md"
if (Test-Path $targetSkill) {
    Write-Host "      [OK] Verified SKILL.md in global library." -ForegroundColor Green
    Write-Host "`n[SUCCESS] Global Skill 'liangsheng-theater' deployed successfully!" -ForegroundColor Green
    Write-Host "Awakening phrases: '有请凉笙歌剧院' / '/curtain-up' / '/opera'" -ForegroundColor Yellow
} else {
    Write-Host "      [ERROR] Verification failed: SKILL.md not found!" -ForegroundColor Red
    exit 1
}

Write-Host "==========================================================" -ForegroundColor Cyan
