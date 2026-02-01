@echo off
chcp 65001 >nul
echo ========================================
echo CSAC路由器编译错误修复脚本
echo ========================================
echo.
echo 修复设备树文件问题...
echo.
echo 1. 确保设备树文件存在
if not exist "target\linux\ath79\dts\_csac-csac-router.dts" (
    echo [ERROR] 设备树文件不存在
    echo 请运行 create_device_tree.py 生成设备树文件
    pause
    exit /b 1
)
echo [OK] 设备树文件存在
echo.
echo 2. 确保Makefile配置正确
findstr /C:"csac-csac-router" "target\linux\ath79\image\Makefile" >nul
if %errorlevel% neq 0 (
    echo [ERROR] Makefile中没有CSAC设备定义
    pause
    exit /b 1
)
echo [OK] Makefile配置正确
echo.
echo 3. 提交并推送到GitHub...
git add --force target/linux/ath79/dts/_csac-csac-router.dts
git add target/linux/ath79/image/Makefile
git commit -m "Fix: 设备树文件命名问题，确保编译通过"
echo.
echo 4. 推送到GitHub...
git push origin main
echo.
echo ========================================
echo 修复完成！
echo ========================================
echo.
echo 现在可以在GitHub Actions查看编译状态
echo.
pause
