@echo off
chcp 65001 >nul
echo ========================================
echo CSAC路由器ART节点验证脚本
echo ========================================
echo.
echo 验证ART节点配置...
echo.
echo 1. 检查ART节点定义...
findstr /C:"art: partition@20000" "target\linux\ath79\dts\_csac-csac-router.dts" >nul
if %errorlevel% equ 0 (
    echo [OK] ART节点定义存在
) else (
    echo [ERROR] ART节点定义不存在
)
echo.
echo 2. 检查ART节点reg属性...
findstr /C:"reg = <0x020000 0x010000>" "target\linux\ath79\dts\_csac-csac-router.dts" >nul
if %errorlevel% equ 0 (
    echo [OK] ART节点reg属性正确
) else (
    echo [ERROR] ART节点reg属性错误
)
echo.
echo 3. 检查WLAN节点引用...
findstr /C:"mtd-cal-data = <&art 0x1000>" "target\linux\ath79\dts\_csac-csac-router.dts" >nul
if %errorlevel% equ 0 (
    echo [OK] WLAN节点正确引用ART节点
) else (
    echo [ERROR] WLAN节点没有正确引用ART节点
)
echo.
echo 4. 检查Makefile配置...
findstr /C:"csac-csac-router" "target\linux\ath79\image\Makefile" >nul
if %errorlevel% equ 0 (
    echo [OK] Makefile设备定义存在
) else (
    echo [ERROR] Makefile设备定义不存在
)
echo.
echo ========================================
echo 验证完成！
echo ========================================
echo.
echo 运行 fix_art_node.bat 推送到GitHub
echo.
pause
