#!/usr/bin/env bash
# install.sh - Liangsheng Opera House One-Click Installer for macOS/Linux
set -e

TARGET_DIR="$HOME/.gemini/config/skills/liangsheng-theater"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=========================================================="
echo "  🎭 凉笙歌剧院 (Liangsheng Opera House) 一键安装程序"
echo "=========================================================="
echo "安装源路径: $SOURCE_DIR"
echo "目标技能库: $TARGET_DIR"

mkdir -p "$TARGET_DIR"

# 复制核心文件
for file in SKILL.md README.md GLOSSARY.md THEATER_BLUEPRINT.md LICENSE; do
  if [ -f "$SOURCE_DIR/$file" ]; then
    cp "$SOURCE_DIR/$file" "$TARGET_DIR/$file"
    echo "  [OK] $file"
  fi
done

# 复制目录
for dir in templates .theater docs scripts; do
  if [ -d "$SOURCE_DIR/$dir" ]; then
    mkdir -p "$TARGET_DIR/$dir"
    cp -R "$SOURCE_DIR/$dir/"* "$TARGET_DIR/$dir/"
    echo "  [OK] 目录同步: $dir"
  fi
done

if [ -f "$TARGET_DIR/SKILL.md" ]; then
  echo ""
  echo "🎉 【安装成功】凉笙歌剧院已成功部署至您的全局 AI 技能库！"
  echo "──────────────────────────────────────────────────────────"
  echo "【如何使用】：在任何项目或对话中，对 AI 输入以下任一口令即可开戏："
  echo "  1. 自然语言：‘有请凉笙歌剧院’ 或 ‘歌剧院开戏’"
  echo "  2. 快捷指令：/curtain-up 或 /opera"
  echo "【官方预置智囊】：查理·芒格 / 安迪·格鲁夫 / 稻盛和夫"
  echo "──────────────────────────────────────────────────────────"
else
  echo "  [ERROR] 校验失败：未在目标位置找到 SKILL.md！"
  exit 1
fi
