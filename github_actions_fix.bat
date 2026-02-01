@echo off
chcp 65001 >nul
echo ========================================
echo GitHub Actions工作流修复脚本
echo ========================================
echo.
echo 1. 创建.github/workflows目录...
if not exist ".github\workflows" (
    mkdir ".github\workflows"
    echo [OK] 创建.github/workflows目录
)
echo.
echo 2. 复制GitHub Actions工作流文件...
copy "github_actions_fix.bat" ".github\workflows\build.yml" /y
if exist ".github\workflows\build.yml" (
    echo [OK] GitHub Actions工作流文件已复制
) else (
    echo [ERROR] 复制失败
    pause
    exit /b 1
)
echo.
echo 3. 提交GitHub Actions更改...
git add .github/workflows/build.yml
git commit -m "Update: GitHub Actions工作流，修复固件上传问题
- 添加文件列表显示步骤
- 添加多个文件上传步骤
- 添加目录结构上传步骤
- 修复csac文件匹配问题"
echo.
echo 4. 推送到GitHub...
git push origin main
echo.
echo ========================================
echo GitHub Actions修复完成！
echo ========================================
echo.
echo ✅ GitHub Actions工作流已更新
echo.
echo 现在访问 https://github.com/mrlong32/openwrt/actions
echo 查看最新的编译工作流
echo.
pause
