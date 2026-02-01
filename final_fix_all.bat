@echo off
chcp 65001 >nul
echo ========================================
echo CSAC路由器固件编译 - 最终一键修复脚本
echo ========================================
echo.
echo 执行所有修复步骤...
echo.
echo 1. 验证配置...
call verify_final_config.bat
if %errorlevel% neq 0 (
    echo [ERROR] 配置验证失败
    pause
    exit /b 1
)
echo.
echo 2. 修复GitHub Actions...
call github_actions_fix.bat
if %errorlevel% neq 0 (
    echo [ERROR] GitHub Actions修复失败
    pause
    exit /b 1
)
echo.
echo 3. 推送所有更改...
call push_all_fixes.bat
if %errorlevel% neq 0 (
    echo [ERROR] 推送失败
    pause
    exit /b 1
)
echo.
echo ========================================
echo 所有修复完成！
echo ========================================
echo.
echo ✅ 所有问题已修复并推送到GitHub
echo.
echo 现在：
echo 1. 访问 https://github.com/mrlong32/openwrt/actions
echo 2. 查看最新的编译工作流
echo 3. 等待编译完成，下载CSAC固件
echo.
echo 预计固件文件名：
echo   openwrt-ath79-generic-csac-router-squashfs-sysupgrade.bin
echo   openwrt-ath79-generic-csac-router-squashfs-factory.bin
echo.
echo 如果还有问题，请检查：
echo   - 设备树文件是否正确
echo   - Makefile配置是否正确
echo   - .config文件是否启用CSAC设备
echo.
pause
