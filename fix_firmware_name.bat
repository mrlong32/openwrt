@echo off
chcp 65001 >nul
echo ========================================
echo CSAC路由器固件命名修复脚本
echo ========================================
echo.
echo 检查设备树文件...
if not exist "target\linux\ath79\dts\_csac-csac-router.dts" (
    echo [ERROR] 设备树文件不存在
    pause
    exit /b 1
)
echo [OK] 设备树文件存在
echo.
echo 检查Makefile配置...
findstr /C:"csac-csac-router" "target\linux\ath79\image\Makefile" >nul
if %errorlevel% neq 0 (
    echo [ERROR] Makefile中没有CSAC设备定义
    pause
    exit /b 1
)
echo [OK] Makefile配置存在
echo.
echo 1. 复制设备树文件到正确名称...
copy "target\linux\ath79\dts\_csac-csac-router.dts" "target\linux\ath79\dts\csac-router.dts" /y
echo [OK] 设备树文件已复制到csac-router.dts
echo.
echo 2. 更新Makefile配置...
set "tempfile=%temp%\temp_makefile.txt"
findstr /v "define Device/csac-csac-router" "target\linux\ath79\image\Makefile" > "%tempfile%"
echo. >> "%tempfile%"
echo define Device/csac-router >> "%tempfile%"
echo   ATH_SOC := qca9563 >> "%tempfile%"
echo   DEVICE_VENDOR := CSAC >> "%tempfile%"
echo   DEVICE_MODEL := Router >> "%tempfile%"
echo   DEVICE_DTS := csac-router.dts >> "%tempfile%"
echo   SUPPORTED_DEVICES := csac-router csac-csac-router >> "%tempfile%"
echo   DEVICE_PACKAGES := ^\ >> "%tempfile%"
echo     kmod-ath10k ath10k-firmware-qca9886 ^\ >> "%tempfile%"
echo     luci luci-theme-bootstrap ^\ >> "%tempfile%"
echo     swconfig iw hostapd >> "%tempfile%"
echo   IMAGE_SIZE := 16064k >> "%tempfile%"
echo   BLOCKSIZE := 64k >> "%tempfile%"
echo   PAGESIZE := 256 >> "%tempfile%"
echo endef >> "%tempfile%"
echo TARGET_DEVICES += csac-router >> "%tempfile%"
move /y "%tempfile%" "target\linux\ath79\image\Makefile"
echo [OK] Makefile已更新
echo.
echo 3. 提交更改...
git add --force target/linux/ath79/dts/csac-router.dts
git add target/linux/ath79/image/Makefile
git commit -m "Fix: 固件命名问题，确保文件名包含csac"
echo.
echo 4. 推送到GitHub...
git push origin main
echo.
echo ========================================
echo 修复完成！
echo ========================================
echo.
echo ✅ 固件命名问题已修复
echo.
echo 现在固件文件名将包含csac关键词
echo.
pause
