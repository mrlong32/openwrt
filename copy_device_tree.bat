@echo off
chcp 65001 >nul
echo ========================================
echo 设备树文件复制脚本（备用）
echo ========================================
echo.
echo 复制设备树文件到多个位置...
echo.
copy "target\linux\ath79\dts\_csac-csac-router.dts" "target\linux\ath79\dts\csac-csac-router.dts" /y
copy "target\linux\ath79\dts\_csac-csac-router.dts" "target\linux\ath79\dts\csac-router.dts" /y
echo.
echo 已复制到:
echo  - target\linux\ath79\dts\csac-csac-router.dts
echo  - target\linux\ath79\dts\csac-router.dts
echo.
echo 确保所有可能的文件名都存在
echo.
pause
