@echo off
chcp 65001 >nul
echo ========================================
echo CSAC路由器配置最终验证脚本
echo ========================================
echo.
echo 验证所有配置是否正确...
echo.
echo 1. 设备树文件验证...
if exist "target\linux\ath79\dts\csac-router.dts" (
    echo [OK] 新设备树文件存在
) else (
    echo [ERROR] 新设备树文件不存在
)
echo.
echo 2. Makefile设备定义验证...
findstr /C:"define Device/csac-router" "target\linux\ath79\image\Makefile" >nul
if %errorlevel% equ 0 (
    echo [OK] csac-router设备定义存在
) else (
    echo [ERROR] csac-router设备定义不存在
)
echo.
echo 3. 检查设备树文件名配置...
findstr /C:"DEVICE_DTS := csac-router.dts" "target\linux\ath79\image\Makefile" >nul
if %errorlevel% equ 0 (
    echo [OK] 设备树文件名配置正确
) else (
    echo [ERROR] 设备树文件名配置错误
)
echo.
echo 4. 检查支持的设备列表...
findstr /C:"SUPPORTED_DEVICES := csac-router csac-csac-router" "target\linux\ath79\image\Makefile" >nul
if %errorlevel% equ 0 (
    echo [OK] 支持的设备列表正确
) else (
    echo [ERROR] 支持的设备列表错误
)
echo.
echo 5. 检查.config文件...
if exist ".config" (
    echo [OK] .config文件存在
    findstr /C:"CONFIG_TARGET_ath79_generic=y" ".config" >nul
    if %errorlevel% equ 0 (
        echo [OK] ath79平台已启用
    ) else (
        echo [ERROR] ath79平台未启用
    )
) else (
    echo [ERROR] .config文件不存在
)
echo.
echo ========================================
echo 验证完成！
echo ========================================
echo.
echo 运行 push_all_fixes.bat 推送到GitHub
echo.
pause
