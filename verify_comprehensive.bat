@echo off
chcp 65001 >nul
echo ========================================
echo CSAC路由器配置综合验证脚本
echo ========================================
echo.
echo 验证所有配置是否正确...
echo.
echo 1. 设备树文件验证...
if not exist "target\linux\ath79\dts\_csac-csac-router.dts" (
    echo [ERROR] 设备树文件不存在
) else (
    echo [OK] 设备树文件存在
    findstr /C:"compatible = "csac,csac-router"" "target\linux\ath79\dts\_csac-csac-router.dts" >nul
    if %errorlevel% equ 0 (
        echo [OK] 设备树兼容性配置正确
    ) else (
        echo [ERROR] 设备树兼容性配置错误
    )
)
echo.
echo 2. ART节点验证...
findstr /C:"art: partition@20000" "target\linux\ath79\dts\_csac-csac-router.dts" >nul
if %errorlevel% equ 0 (
    echo [OK] ART节点定义存在
) else (
    echo [ERROR] ART节点定义不存在
)
findstr /C:"reg = <0x020000 0x010000>" "target\linux\ath79\dts\_csac-csac-router.dts" >nul
if %errorlevel% equ 0 (
    echo [OK] ART节点reg属性正确
) else (
    echo [ERROR] ART节点reg属性错误
)
echo.
echo 3. WLAN节点验证...
findstr /C:"mtd-cal-data = <&art 0x1000>" "target\linux\ath79\dts\_csac-csac-router.dts" >nul
if %errorlevel% equ 0 (
    echo [OK] WLAN节点正确引用ART节点
) else (
    echo [ERROR] WLAN节点没有正确引用ART节点
)
echo.
echo 4. Makefile验证...
findstr /C:"define Device/csac-csac-router" "target\linux\ath79\image\Makefile" >nul
if %errorlevel% equ 0 (
    echo [OK] Makefile设备定义存在
) else (
    echo [ERROR] Makefile设备定义不存在
)
findstr /C:"DEVICE_DTS := _csac-csac-router.dts" "target\linux\ath79\image\Makefile" >nul
if %errorlevel% equ 0 (
    echo [OK] 设备树文件引用正确
) else (
    echo [ERROR] 设备树文件引用错误
)
echo.
echo 5. .config文件验证...
if exist ".config" (
    echo [OK] .config文件存在
    findstr /C:"CONFIG_TARGET_ath79_generic_DEVICE_csac-csac-router=y" ".config" >nul
    if %errorlevel% equ 0 (
        echo [OK] .config中CSAC设备已启用
    ) else (
        echo [ERROR] .config中CSAC设备未启用
    )
) else (
    echo [ERROR] .config文件不存在
)
echo.
echo ========================================
echo 验证完成！
echo ========================================
echo.
echo 运行 final_push_csac.bat 开始编译！
echo.
pause
