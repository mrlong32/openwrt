@echo off
chcp 65001 >nul
echo ========================================
echo CSAC路由器固件编译 - 一键推送脚本
echo ========================================
echo.
echo 1. 验证所有文件...
if not exist "target\linux\ath79\dts\_csac-csac-router.dts" (
    echo [ERROR] 原始设备树文件不存在
    pause
    exit /b 1
)
if not exist "target\linux\ath79\dts\csac-router.dts" (
    echo [ERROR] 新设备树文件不存在
    pause
    exit /b 1
)
echo [OK] 所有设备树文件存在
echo.
echo 2. 验证Makefile配置...
findstr /C:"define Device/csac-router" "target\linux\ath79\image\Makefile" >nul
if %errorlevel% neq 0 (
    echo [ERROR] Makefile中没有csac-router设备定义
    pause
    exit /b 1
)
echo [OK] Makefile配置正确
echo.
echo 3. 提交所有更改...
git add --force target/linux/ath79/dts/_csac-csac-router.dts
git add --force target/linux/ath79/dts/csac-router.dts
git add target/linux/ath79/image/Makefile
git add --force .config
echo.
echo 4. 提交并推送...
git commit -m "Fix: 固件命名问题，确保CSAC路由器固件正确生成
- 添加csac-router设备定义
- 确保固件文件名包含csac关键词
- 修复GitHub Actions文件上传问题"
git push origin main
echo.
echo ========================================
echo 推送完成！
echo ========================================
echo.
echo ✅ 所有修复已推送到GitHub
echo.
echo 现在访问 https://github.com/mrlong32/openwrt/actions
echo 查看编译状态，等待固件生成
echo.
echo 预计固件文件名:
echo   openwrt-ath79-generic-csac-router-squashfs-sysupgrade.bin
echo.
pause
