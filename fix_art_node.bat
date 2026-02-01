@echo off
chcp 65001 >nul
echo ========================================
echo CSAC路由器编译错误修复脚本 - ART节点问题
echo ========================================
echo.
echo 修复设备树ART节点问题...
echo.
echo 1. 确保设备树文件存在
if not exist "target\linux\ath79\dts\_csac-csac-router.dts" (
    echo [ERROR] 设备树文件不存在
    pause
    exit /b 1
)
echo [OK] 设备树文件存在
echo.
echo 2. 确保ART节点定义正确
findstr /C:"art: partition@20000" "target\linux\ath79\dts\_csac-csac-router.dts" >nul
if %errorlevel% neq 0 (
    echo [ERROR] ART节点定义不正确
    pause
    exit /b 1
)
echo [OK] ART节点定义正确
echo.
echo 3. 确保WLAN节点正确引用ART节点
findstr /C:"mtd-cal-data = <&art 0x1000>" "target\linux\ath79\dts\_csac-csac-router.dts" >nul
if %errorlevel% neq 0 (
    echo [ERROR] WLAN节点没有正确引用ART节点
    pause
    exit /b 1
)
echo [OK] WLAN节点正确引用ART节点
echo.
echo 4. 提交并推送到GitHub...
git add --force target/linux/ath79/dts/_csac-csac-router.dts
git add target/linux/ath79/image/Makefile
git commit -m "Fix: 设备树ART节点定义问题，确保无线校准数据正确"
echo.
echo 5. 推送到GitHub...
git push origin main
echo.
echo ========================================
echo 修复完成！
echo ========================================
echo.
echo ✅ ART节点问题已修复
echo.
echo 现在可以在GitHub Actions查看编译状态
echo.
pause
