@echo off
chcp 65001 >nul
echo ========================================
echo GitHub Actions修复脚本
echo ========================================
echo.
echo 检查.github/workflows目录...
if not exist ".github\workflows" (
    mkdir ".github\workflows"
    echo [OK] 创建.github/workflows目录
)
echo.
echo 生成新的GitHub Actions脚本...
set "actions_file=.github\workflows\build.yml"
echo name: Build OpenWrt Firmware > "%actions_file%"
echo on: >> "%actions_file%"
echo   push: >> "%actions_file%"
echo     branches: [ main ] >> "%actions_file%"
echo   pull_request: >> "%actions_file%"
echo     branches: [ main ] >> "%actions_file%"
echo   workflow_dispatch: >> "%actions_file%"
echo. >> "%actions_file%"
echo jobs: >> "%actions_file%"
echo   build: >> "%actions_file%"
echo     runs-on: ubuntu-latest >> "%actions_file%"
echo     steps: >> "%actions_file%"
echo       - name: Checkout code >> "%actions_file%"
echo         uses: actions/checkout@v4 >> "%actions_file%"
echo. >> "%actions_file%"
echo       - name: Update and install dependencies >> "%actions_file%"
echo         run: | >> "%actions_file%"
echo           sudo apt update >> "%actions_file%"
echo           sudo apt install -y build-essential clang flex bison g++ gawk gcc-multilib g++-multilib gettext git libncurses5-dev libssl-dev python3-distutils rsync unzip zlib1g-dev file wget >> "%actions_file%"
echo. >> "%actions_file%"
echo       - name: Build firmware >> "%actions_file%"
echo         run: | >> "%actions_file%"
echo           make defconfig >> "%actions_file%"
echo           make download -j$(nproc) >> "%actions_file%"
echo           make -j$(nproc) || make -j1 V=s >> "%actions_file%"
echo. >> "%actions_file%"
echo       - name: Upload firmware artifacts >> "%actions_file%"
echo         uses: actions/upload-artifact@v4 >> "%actions_file%"
echo         with: >> "%actions_file%"
echo           name: openwrt-firmware >> "%actions_file%"
echo           path: bin/targets/ath79/generic/*.bin >> "%actions_file%"
echo. >> "%actions_file%"
echo       - name: Upload specific CSAC firmware >> "%actions_file%"
echo         uses: actions/upload-artifact@v4 >> "%actions_file%"
echo         with: >> "%actions_file%"
echo           name: csac-firmware >> "%actions_file%"
echo           path: | >> "%actions_file%"
echo             bin/targets/ath79/generic/*csac* >> "%actions_file%"
echo             bin/targets/ath79/generic/*CSAC* >> "%actions_file%"
echo             bin/targets/ath79/generic/*router* >> "%actions_file%"
echo         if: always() >> "%actions_file%"
echo. >> "%actions_file%"
echo [OK] GitHub Actions脚本已生成
echo.
echo 提交GitHub Actions更改...
git add .github/workflows/build.yml
git commit -m "Update: GitHub Actions脚本，修复固件上传问题"
git push origin main
echo.
echo ========================================
echo GitHub Actions修复完成！
echo ========================================
echo.
pause
