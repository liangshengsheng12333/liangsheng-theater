# install.ps1 - Liangsheng Opera House One-Click Installer
[CmdletBinding()]
param(
    [string]$TargetDir = "$env:USERPROFILE\.gemini\config\skills\liangsheng-theater"
)

$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  🎭 凉笙歌剧院 (Liangsheng Opera House) 一键安装程序" -ForegroundColor Yellow
Write-Host "==========================================================" -ForegroundColor Cyan

$SourceDir = $PSScriptRoot
Write-Host "安装源路径: $SourceDir" -ForegroundColor Gray
Write-Host "目标技能库: $TargetDir" -ForegroundColor Gray

# 1. 确保目标目录存在
if (!(Test-Path -Path $TargetDir)) {
    Write-Host "`n[1/4] 创建全局技能目录..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
    Write-Host "      创建成功: $TargetDir" -ForegroundColor Green
} else {
    Write-Host "`n[1/4] 目标目录已存在，准备覆盖升级..." -ForegroundColor Cyan
}

# 2. 复制核心规范文件
Write-Host "`n[2/4] 安装核心规范与蓝图..." -ForegroundColor Cyan
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
        Write-Host "      [OK] $file" -ForegroundColor Green
    }
}

# 3. 递归复制模板、文档、预置资产和脚本
Write-Host "`n[3/4] 安装上游标准模板与官方三大智囊资产库..." -ForegroundColor Cyan
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
        Write-Host "      [OK] 目录同步: $dir" -ForegroundColor Green
    }
}

# 4. 验证完整性
Write-Host "`n[4/4] 校验安装完整性..." -ForegroundColor Cyan
$targetSkill = Join-Path $TargetDir "SKILL.md"
if (Test-Path $targetSkill) {
    Write-Host "      [OK] 核心技能 SKILL.md 校验通过！" -ForegroundColor Green
    Write-Host "`n🎉 【安装成功】凉笙歌剧院已成功部署至您的全局 AI 技能库！" -ForegroundColor Green
    Write-Host "──────────────────────────────────────────────────────────" -ForegroundColor Yellow
    Write-Host "【如何使用】：在任何项目或对话中，对 AI 输入以下任一口令即可开戏：" -ForegroundColor White
    Write-Host "  1. 自然语言（推荐）：‘有请凉笙歌剧院’ 或 ‘歌剧院开戏’" -ForegroundColor Cyan
    Write-Host "  2. 极速暗号指令：    /curtain-up  或  /opera" -ForegroundColor Cyan
    Write-Host "【官方预置智囊】：查理·芒格 / 安迪·格鲁夫 / 稻盛和夫（直接点名秒开戏！）" -ForegroundColor Yellow
    Write-Host "──────────────────────────────────────────────────────────" -ForegroundColor Yellow
} else {
    Write-Host "      [ERROR] 校验失败：未在目标位置找到 SKILL.md！" -ForegroundColor Red
    exit 1
}

Write-Host "==========================================================" -ForegroundColor Cyan
