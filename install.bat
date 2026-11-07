@echo off
chcp 65001 >nul
title 凉笙歌剧院一键安装程序
echo 正在启动凉笙歌剧院一键安装...
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1"
echo.
pause
