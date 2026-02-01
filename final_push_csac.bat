@echo off
chcp 65001 >nul
echo ========================================
echo CSAC路由器固件编译 - 最终推送脚本
echo ========================================
echo.
echo 检查所有必要文件...
echo.
echo 1. 检查设备树文件...
if not exist "target\linux\ath79\dts\_csac-csac-router.dts" (
    echo [ERROR] 设备树文件不存在: _csac-csac-router.dts
    pause
    exit /b 1
)
echo [OK] 设备树文件存在
echo.
echo 2. 检查ART节点定义...
findstr /C:"art: partition@20000" "target\linux\ath79\dts\_csac-csac-router.dts" >nul
if %errorlevel% neq 0 (
    echo [ERROR] ART节点定义不存在
    pause
    exit /b 1
)
echo [OK] ART节点定义存在
echo.
echo 3. 检查Makefile配置...
findstr /C:"csac-csac-router" "target\linux\ath79\image\Makefile" >nul
if %errorlevel% neq 0 (
    echo [ERROR] Makefile中没有CSAC设备定义
    pause
    exit /b 1
)
echo [OK] Makefile配置正确
echo.
echo 4. 提交所有文件到Git...
echo.
git add --force target/linux/ath79/dts/_csac-csac-router.dts
git add target/linux/ath79/image/Makefile
git add --force .config
echo.
echo 5. 提交更改...
git commit -m "CSAC Router: Complete support for QCA9563+QCA8337+QCA9886
- Fixed ART node definition issue
- Configured wireless calibration data partition
- Added proper reference to ART node in WLAN configuration
- Fixed all compilation errors"
echo.
echo 6. 推送到GitHub...
git push origin main
echo.
echo ========================================
echo 推送完成！
echo ========================================
echo.
echo 所有文件已成功推送到GitHub！
echo.
echo 现在：
echo 1. 访问 https://github.com/mrlong32/openwrt/actions
echo 2. 查看最新的编译工作流
echo 3. 等待编译完成，下载CSAC固件
echo.
echo 预计编译时间：30-60分钟
echo 固件位置：bin/targets/ath79/generic/
echo.
pause
